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

    with open(diff_path, "r", encoding="utf-8") as f:
        diff_content = f.read().strip()
        
    if not diff_content:
        print("APROVADO")
        return

    prompt = f"Você é um revisor de código estrito. Analise este diff e verifique se as alterações estão seguras para irem para produção. Responda ESTRITAMENTE com a palavra APROVADO (sem nenhum outro texto ou pontuação) se estiver tudo ok, ou REJEITADO seguido do motivo se houver algo crítico ou que quebre o sistema.\n\nDiff:\n{diff_content}"

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
            print("REJEITADO - IA falhou em responder adequadamente.")
            
    except subprocess.CalledProcessError as e:
        print(f"REJEITADO Erro ao executar a IA: {e.stderr}")

if __name__ == "__main__":
    main()
