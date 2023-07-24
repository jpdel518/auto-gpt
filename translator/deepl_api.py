import os
import deepl
from dotenv import load_dotenv

load_dotenv()

class DeepLTranslator:
    def __init__(self):
        self.auth_key = os.environ['DEEPL_API_KEY']
        self.translator = deepl.Translator(self.auth_key)

    def translate_text(self, text, target_lang):
        result = self.translator.translate_text(text, target_lang=target_lang)
        return result.text
