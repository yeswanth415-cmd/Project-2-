FROM hshar/webapp

WORKDIR /var/www/html

COPY . /var/www/html

RUN pip3 install --no-cache-dir -r requirements.txt || true

EXPOSE 5000

CMD ["python3", "app.py"]
