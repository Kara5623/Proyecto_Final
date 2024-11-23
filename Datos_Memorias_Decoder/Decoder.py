import tkinter as tk
from tkinter import filedialog, messagebox

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

# Función para decodificar instrucciones de tipo I y R
def decode_text(text_widget):
    content = text_widget.get(1.0, tk.END).strip()
    try:
        binary_lines = []
        for line in content.splitlines():
            if line.strip():  # Ignorar líneas vacías
                # Convertir la línea hexadecimal a binario
                hex_value = line.strip()
                binary_value = bin(int(hex_value, 16))[2:].zfill(32)  # Convertir a binario de 32 bits
                binary_lines.append(binary_value)

        # Insertar las líneas convertidas en el widget de texto
        text_widget.delete(1.0, tk.END)
        text_widget.insert(tk.END, '\n'.join(binary_lines))
    except ValueError:
        messagebox.showerror("Error", "Invalid hexadecimal input.")
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
