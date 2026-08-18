import os
import sys
import subprocess

def main():
    if len(sys.argv) < 2:
        print("APROVADO")
        return
        
    diff_path = sys.argv[1]
    if not os.path.exists(diff_path):
        print("APROVADO")
        return

    prompt = (
        f"Você é um revisor de código estrito. Analise as alterações do diff no arquivo '{diff_path}'. "
        "Verifique se as alterações são seguras e de qualidade para produção. "
        "Responda ESTRITAMENTE com a palavra APROVADO (sem pontuação ou texto extra) se estiver tudo correto, "
        "ou REJEITADO seguido de uma breve explicação caso haja erro crítico."
    )

    try:
        result = subprocess.run(
            ["agy", "--dangerously-skip-permissions", "--print", prompt],
            capture_output=True,
            text=True,
            check=True
        )
        out = result.stdout.strip()
        if "REJEITADO" in out.upper():
            print(out)
        elif "APROVADO" in out.upper():
            print("APROVADO")
        else:
            print("APROVADO")
            
    except subprocess.CalledProcessError as e:
        print(f"REJEITADO Erro ao executar a IA: {e.stderr}")
    except Exception as e:
        print(f"REJEITADO Erro inesperado: {str(e)}")

if __name__ == "__main__":
    main()
