# Recipe Generator
<img width="1503" alt="app" src="https://github.com/user-attachments/assets/181ece27-ec5c-4b59-93fa-16601157d469" />

## Setup:

### Backend
```bash
cd backend
mv example.env .env  # rename example.env to .env and provide your GROQ_API_KEY in .env
bundle install && rails server
```

### Frontend
```bash
cd frontend
npm install && npm start
```

### Run backend tests:
```bash
cd backend
bundle exec rspec
```


