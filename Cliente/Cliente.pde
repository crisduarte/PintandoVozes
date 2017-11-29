import processing.net.*;

String ip_servidor = "192.168.0.26";
int porta_servidor = 5204;

float clientId;
Client cliente;
Pincel pincel;
float fatorRaio;

void setup(){
  size(1024, 768);
  colorMode(HSB, hsb_mode);
  background(0);
  
  fatorRaio = 1;
  float raio = width / 4 / fatorRaio;
  float X = -raio / 2;
  float Y = height - raio / 2;
  pincel = new Pincel(X, Y, raio);
  
  confAudio();
  
  clientId = random(1.0);
  println("Contactando servidor " + ip_servidor + "...");
  cliente = new Client(this, ip_servidor, porta_servidor);
};

void enviarServidor(float clientId, Pincel pincel){
  cliente.write(clientId + ";" + pincel.X + ";" + pincel.Y + ";" + pincel.raio + ";" + pincel.matiz + "\n");
};

void draw(){
  float a = amplitude();
  fatorRaio = map(a, 0.0, 0.5, 1.0, 2.0) * (pincel.alturaRelativa() + 0.2);
  pincel.aumentar(fatorRaio);
  pincel.mover(map(a, 0.0, 0.5, 0.1, pincel.raio / 6 * fatorRaio), 
               -map(a, 0.01, 0.5, (pincel.Y - pincel.YMin) / (pincel.raio / 4 * fatorRaio) - 1, (pincel.raio / 8 * fatorRaio)));
  enviarServidor(clientId, pincel);
  pincel.pintar();
}