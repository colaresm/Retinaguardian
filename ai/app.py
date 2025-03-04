from flask import Flask
from routes.routes import classify_bp

app = Flask(__name__)

# Registrar blueprint da rota de classificação
app.register_blueprint(classify_bp, url_prefix='/api')

if __name__ == "__main__":
    import tensorflow as tf
    print(tf.__version__)
    app.run(debug=True)

# the env name is dev_env
