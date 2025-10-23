FROM node:18-alpine

# Install Python and Blender dependencies
RUN apk add --no-cache python3 py3-pip blender

WORKDIR /app

# Copy package files
COPY frontend/package*.json ./frontend/
COPY backend/requirements.txt ./backend/

# Install dependencies
RUN cd frontend && npm install
RUN pip3 install -r backend/requirements.txt

# Copy source code
COPY . .

# Expose port
EXPOSE 5173

# Start both frontend and backend
CMD ["sh", "-c", "cd backend && python3 -m uvicorn main:app --host 0.0.0.0 --port 8000 & cd frontend && npm run dev -- --host 0.0.0.0"]
