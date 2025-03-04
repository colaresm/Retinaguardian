from flask import Blueprint, request, jsonify
from tensorflow import keras
import cv2
import numpy as np
from utils import get_class_name

classify_bp = Blueprint('classify', __name__)

@classify_bp.route('/classify', methods=['POST'])
def classify_image():
    if 'retinography' not in request.files:
        return jsonify({"error": "Nenhuma imagem enviada"}), 400

    file = request.files['retinography']
    file_bytes = np.frombuffer(file.read(), np.uint8) 
    if file_bytes.size == 0:
        return jsonify({"error": "Bytes vazios"}), 400
    image = cv2.imdecode(file_bytes, cv2.IMREAD_COLOR)  

    if image is None:
        return jsonify({"error": "Falha ao processar a imagem"}), 400

    image = cv2.resize(image, (224, 224), interpolation=cv2.INTER_LINEAR)

    image = np.expand_dims(image, axis=0)  

    model = keras.models.load_model("models/classification_model.keras")
    prediction = model.predict(image)[0][0]   

    predicted_class = 1 if prediction >= 0.5 else 0
    return jsonify({"prediction":get_class_name(int(predicted_class)) })



#the env name is venv