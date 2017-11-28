import processing.net.*;

float clientId;

class Pincel{
  public float X;
  public float Y;
  public float raio;
  public float matiz;
  public float YMin;
  
  Pincel(float X, float Y, float raio){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    this.YMin = this.Y;
    this.matiz = random(100);
  };
  
  public Pincel atualizar(float X, float Y, float raio){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    if (this.Y < this.YMin) this.YMin = this.Y;
    return this;
  };
  
  public float alturaRelativa(float escala, float deslocamento){
    return escala * (this.Y + this.raio) / (height + this.raio) + deslocamento;
  };
  
  public float alturaRelativa(float escala){
    return alturaRelativa(escala, 0);
  };
  
  public float alturaRelativa(){
    return alturaRelativa(1, 0);
  };
  
  public void pintar(){
    pushStyle();
    noStroke();
    fill(color(this.matiz - this.alturaRelativa(30, -15), 100 - this.alturaRelativa(100), 100 - pow(this.alturaRelativa(), 2) * 100), 31);
    ellipse(this.X, this.Y, this.raio, this.raio);
    popStyle();
  };
  
  public void aumentar(float fatorRaio){
    this.raio = width / 4 / fatorRaio;
  };
  
  public void mover(float deltaX, float deltaY){
    // mover X
    if (this.X > width)
      this.X = -this.raio;
    else if (X < -this.raio)
      this.X = width + this.raio;
    this.X += deltaX;
    // mover Y
    if (this.Y > height)
      this.Y = height;
    else if (Y < -this.raio){
      this.Y = height;
      this.YMin = this.Y;
    }
    this.Y += deltaY;
    if (this.Y < this.YMin) this.YMin = this.Y;
  };
};

Client cliente;
Pincel pincel;
float fatorRaio;

void setup(){
  size(1024, 712);
  colorMode(HSB, 100);
  background(0);
  
  fatorRaio = 1; // random(9.0) + 1.0;
  float raio = width / 4 / fatorRaio;
  float X = -raio / 2 + 1;
  float Y = height - raio / 3;
  pincel = new Pincel(X, Y, raio);
  
  confAudio();
  
  clientId = random(1.0);
  cliente = new Client(this, "192.168.0.24", 5204);
};

void draw(){
  float a = amplitude();
  fatorRaio = map(a, 0.0, 0.5, 1.0, 4.0);
  pincel.aumentar(fatorRaio);
  pincel.mover(map(a, 0.0, 0.5, 0.1, pincel.raio / 6 * fatorRaio), 
               -map(a, 0.01, 0.5, (pincel.Y - pincel.YMin) / (pincel.raio / 4 * fatorRaio) - 1, (pincel.raio / 8 * fatorRaio)));
  cliente.write(clientId + ";" + pincel.X + ";" + pincel.Y + ";" + pincel.raio + "\n");
  pincel.pintar();
}