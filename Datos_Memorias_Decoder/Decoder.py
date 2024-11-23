import tkinter as tk
from tkinter import filedialog, messagebox

# Diccionario de las instrucciones MIPS en formato binario (simplificado)
opcode_map = {
    'add': '0000', 'addi': '0001', 'lw': '0010', 'sw': '0011', 'beq': '0100', 'j': '0101'
}

# Función para seleccionar un archivo
def select_file(text_widget):
    file_path = filedialog.askopenfilename()
    if file_path:
        try:
            with open(file_path, 'r') as file:
                content = file.read()
                text_widget.delete(1.0, tk.END)
                text_widget.insert(tk.END, content)
        except FileNotFoundError:
            messagebox.showerror("Error", "File not found.")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to read file: {str(e)}")

# Función para guardar el informe
def save_report(text_widget):
    file_path = filedialog.asksaveasfilename(defaultextension=".txt")
    if file_path:
        try:
            with open(file_path, 'w') as file:
                content = text_widget.get(1.0, tk.END)
                file.write(content.strip())
                messagebox.showinfo("Success", "Report saved successfully!")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to save file: {str(e)}")

# Función para salir de la aplicación
def exit_app(window):
    if messagebox.askokcancel("Exit", "Are you sure you want to exit?"):
        window.destroy()

# Función para convertir un número a binario de 4 bits
def to_binary(value, length=4):
    """Convierte un número a binario con un tamaño específico"""
    return bin(value)[2:].zfill(length)

# Función para convertir instrucciones en formato binario
def convert_instruction(instruction):
    parts = instruction.split()
    opcode = parts[0]

    if opcode == "add":
        # R-type: opcode, rs, rt, rd, shamt, funct (usamos un formato simplificado de 4 bits)
        return f"{opcode_map['add']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3][1:]))} 0000 1000"
    elif opcode == "addi":
        # I-type: opcode, rs, rt, immediate
        return f"{opcode_map['addi']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3]))}"
    elif opcode == "lw":
        # I-type: opcode, rt, address (base + offset)
        return f"{opcode_map['lw']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2]))}"
    elif opcode == "sw":
        # I-type: opcode, rt, address (base + offset)
        return f"{opcode_map['sw']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2]))}"
    elif opcode == "beq":
        # I-type: opcode, rs, rt, offset
        return f"{opcode_map['beq']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3]))}"
    elif opcode == "j":
        # J-type: opcode, address
        return f"{opcode_map['j']} {to_binary(int(parts[1]))}"

# Función para decodificar datos e instrucciones
def decode_text(text_widget):
    content = text_widget.get(1.0, tk.END).strip()
    try:
        lines = content.splitlines()
        data_values = []
        instructions = []
        is_data = True

        for line in lines:
            line = line.strip()
            if line.startswith("//Mdatos"):
                is_data = False  # Start reading instructions after the data section
                continue
            if is_data:
                if line.isdigit():
                    data_values.append(int(line))
            elif line.startswith("//instrucciones"):
                continue  # Skip the instructions header
            else:
                instructions.append(line)

        # Convertir los datos a binario (4 bits)
        binary_data = [to_binary(value, length=4) for value in data_values]

        # Decodificar instrucciones de tipo 'add', 'addi', 'lw', etc.
        decoded_instructions = [convert_instruction(instruction) for instruction in instructions]

        # Mostrar los datos y las instrucciones convertidas a binario
        result = "Datos (en binario):\n"
        result += "\n".join(binary_data) + "\n\n"
        result += "Instrucciones (en binario):\n"
        result += "\n".join(decoded_instructions)

        text_widget.delete(1.0, tk.END)
        text_widget.insert(tk.END, result)

    except Exception as e:
        messagebox.showerror("Error", f"Failed to decode text: {str(e)}")

# Crear la interfaz gráfica
def create_gui():
    window = tk.Tk()
    window.title("Text Analyzer")
    window.geometry("700x600")

    title_label = tk.Label(window, text="Text Analyzer", font=("Arial", 24))
    title_label.pack(pady=10)

    text_widget = tk.Text(window, height=20, width=80)
    text_widget.pack(pady=10)

    # Botones para interactuar con la interfaz
    tk.Button(window, text="Select file", command=lambda: select_file(text_widget)).pack(pady=5)
    tk.Button(window, text="Save Report", command=lambda: save_report(text_widget)).pack(pady=5)
    tk.Button(window, text="Decodificar", command=lambda: decode_text(text_widget)).pack(pady=5)
    tk.Button(window, text="Exit", command=lambda: exit_app(window)).pack(pady=5)

    window.mainloop()

# Ejecutar la interfaz gráfica
create_gui()
