import tkinter as tk
from tkinter import filedialog, messagebox

# Mapa de opcodes para instrucciones
opcode_map = {
    'add': '000000', 'addi': '001000', 'lw': '100011', 'sw': '101011', 'beq': '000100', 'j': '000010'
}

# Función para convertir valores a binario de 32 bits
def to_binary(value, length=32):
    """Convierte un valor numérico a binario de longitud especificada (32 bits por defecto)."""
    return bin(value)[2:].zfill(length)

# Función para convertir instrucciones en formato binario
def convert_instruction(instruction):
    """Convierte una instrucción MIPS a su representación binaria en 32 bits."""
    parts = instruction.split()
    opcode = parts[0]
    
    if opcode == "add":
        # Instrucción R-type: opcode, rs, rt, rd, shamt, funct
        return f"{opcode_map['add']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3][1:]))} {'00000'} {'100000'}"
    elif opcode == "addi":
        # Instrucción I-type: opcode, rs, rt, immediate
        return f"{opcode_map['addi']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3]))}"
    elif opcode == "lw":
        # Instrucción I-type: opcode, rt, base, offset
        return f"{opcode_map['lw']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2]))} {to_binary(int(parts[3]))}"
    elif opcode == "sw":
        # Instrucción I-type: opcode, rt, base, offset
        return f"{opcode_map['sw']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2]))} {to_binary(int(parts[3]))}"
    elif opcode == "beq":
        # Instrucción I-type: opcode, rs, rt, offset
        return f"{opcode_map['beq']} {to_binary(int(parts[1][1:]))} {to_binary(int(parts[2][1:]))} {to_binary(int(parts[3]))}"
    elif opcode == "j":
        # Instrucción J-type: opcode, address
        return f"{opcode_map['j']} {to_binary(int(parts[1]))}"

# Función para decodificar datos e instrucciones
def decode_text(text_widget):
    content = text_widget.get(1.0, tk.END).strip()
    try:
        lines = content.splitlines()
        data_values = []
        instructions = []
        is_data = True

        # Separar los datos de las instrucciones
        for line in lines:
            line = line.strip()
            if line.startswith("//Mdatos"):
                is_data = False
                continue
            if is_data:
                if line.isdigit():
                    data_values.append(int(line))  # Añadir los datos
            elif line.startswith("//instrucciones"):
                continue  # Saltar la cabecera de instrucciones
            else:
                instructions.append(line)

        # Convertir los datos a binario (32 bits)
        binary_data = [to_binary(value) for value in data_values]

        # Convertir las instrucciones a binario
        decoded_instructions = [convert_instruction(instruction) for instruction in instructions]

        # Formato de salida
        result = "Datos (en binario):\n"
        result += "\n".join(binary_data) + "\n\n"
        result += "Instrucciones (en binario, cada línea de 8 bits):\n"

        # Convertir las instrucciones de 32 bits a 4 líneas de 8 bits
        for instruction in decoded_instructions:
            # Dividir cada instrucción de 32 bits en 4 líneas de 8 bits
            result += '\n'.join([instruction[i:i+8] for i in range(0, len(instruction), 8)]) + '\n'

        text_widget.delete(1.0, tk.END)
        text_widget.insert(tk.END, result)

    except Exception as e:
        messagebox.showerror("Error", f"Failed to decode text: {str(e)}")

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
