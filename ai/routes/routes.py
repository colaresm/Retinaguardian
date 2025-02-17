from flask import Blueprint, request, jsonify
from tensorflow import keras


classify_bp = Blueprint('classify', __name__)

@classify_bp.route('/classify', methods=['POST'])
def classify_image():
    model = keras.models.load_model("models/classification_model.keras")

    """Recebe uma imagem e retorna a classificação da RD."""
    if 'file' not in request.files:
        return jsonify({"error": "Nenhuma imagem enviada"}), 400

    file = request.files['file']
   
    
    
    return jsonify({"diagnosis": "teste"})


#the env name is venv