import os
import smtplib
from email.mime.text import MIMEText

#Config
EMAIL_REMETENTE = os.getenv("EMAIL_REMETENTE")
EMAIL_SECRET_KEY = os.getenv("EMAIL_SECRET_KEY")

def enviar_email(destinatario: str, token: str):
    corpo = f"Clique neste link e recupere sua senha de acesso ao Junta Aí!: {token}"

    msg = MIMEText(corpo)
    msg["Subject"] = "Recuperação de Senha"
    msg["From"] = EMAIL_REMETENTE
    msg["To"] = destinatario

    with smtplib.SMTP("smtp.gmail.com", 587) as servidor:
        servidor.starttls()
        servidor.login(EMAIL_REMETENTE, EMAIL_SECRET_KEY)
        servidor.send_message(msg)
