import os
from flask import Flask, jsonify, render_template, request
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
DATABASE_URL = os.environ["DATABASE_URL"]


def get_conn():
    return psycopg2.connect(DATABASE_URL)


def init_db():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT to_regclass('public.tarefas')")
    exists = cur.fetchone()[0]
    if not exists:
        with open("schema.sql", encoding="utf-8") as f:
            cur.execute(f.read())
        conn.commit()
    cur.close()
    conn.close()


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/api/tarefas")
def listar_tarefas():
    conn = get_conn()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(
        "SELECT id, fase, fase_label, fase_sub, fase_titulo, fase_desc, "
        "pessoa, descricao, guia, concluida FROM tarefas ORDER BY fase, id"
    )
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(rows)


@app.route("/api/tarefas/<int:tarefa_id>", methods=["PATCH"])
def atualizar_tarefa(tarefa_id):
    concluida = request.json.get("concluida")
    if not isinstance(concluida, bool):
        return jsonify({"erro": "campo 'concluida' deve ser booleano"}), 400
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        "UPDATE tarefas SET concluida = %s WHERE id = %s", (concluida, tarefa_id)
    )
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"ok": True})


init_db()

if __name__ == "__main__":
    app.run(debug=True, port=5000)