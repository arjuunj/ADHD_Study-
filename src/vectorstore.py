import os
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_pinecone import PineconeVectorStore
from dotenv import load_dotenv

load_dotenv()

def get_embeddings():
    # Using the same model from your notebook
    embeddings = HuggingFaceEmbeddings(model_name="BAAI/bge-small-en-v1.5")
    return embeddings

def create_vector_store(text_chunks, index_name="adhd-bot"):
    embeddings = get_embeddings()
    
    # Connects using the API key in your .env
    docsearch = PineconeVectorStore.from_documents(
        documents=text_chunks,
        embedding=embeddings,
        index_name=index_name
    )
    return docsearch