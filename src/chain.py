import os
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.chains import create_retrieval_chain
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.prompts import ChatPromptTemplate
from dotenv import load_dotenv

load_dotenv()

def get_rag_chain(retriever):
    # Initialize the Gemini model from your notebook
    chat_model = ChatGoogleGenerativeAI(
        model="gemini-2.0-flash-lite",
        google_api_key=os.getenv("GEMINI_API_KEY"),
        temperature=0.7
    )

    # Your ADHD-specific specialized prompt
    system_prompt = (
        "You are an ADHD-specialized Study Assistant for 10th-standard students. "
        "Your goal is to reduce cognitive load and prevent overwhelm. \n\n"
        "Rules for your response:\n"
        "1. Use 'The 3-Bullet Rule': Summarize information into exactly 3 clear, actionable bullets.\n"
        "2. Use 'Micro-Tasks': Break big topics into 5-minute study tasks.\n"
        "3. Highlight Key Terms: Use **bold** for essential vocabulary.\n"
        "4. Tone: Be encouraging and non-judgmental.\n\n"
        "Context:\n{context}"
    )

    prompt = ChatPromptTemplate.from_messages([
        ("system", system_prompt),
        ("human", "{input}"),
    ])

    # Create the chains
    question_answer_chain = create_stuff_documents_chain(chat_model, prompt)
    rag_chain = create_retrieval_chain(retriever, question_answer_chain)
    
    return rag_chain