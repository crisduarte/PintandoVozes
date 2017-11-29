import processing.net.*;
import java.util.Map;

class Pincel{
  public float X;
  public float Y;
  public float raio;
  public color cor;
  
  Pincel(float X, float Y, float raio){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    this.cor = color(127 + random(127), 127 + random(127), 127 + random(127), 31);
    this.pintar();
  };
  
  public Pincel atualizar(float X, float Y, float raio){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    this.pintar();
    return this;
  };
  
  public void pintar(){
    pushStyle();
    noStroke();
    fill(red(this.cor), green(this.cor), blue(this.cor), 7 + this.Y / height * 63);
    ellipse(this.X, this.Y, this.raio, this.raio);
    popStyle();
  };
};

Server servidor;
Map<String, Pincel> clientes;

void setup(){
  size(1024, 712);
  background(0);
  
  servidor = new Server(this, 5204);
  clientes = new HashMap<String, Pincel>();
  
  println("Endereço do servidor: " + Server.ip());
};

void draw(){
  Client cliente = servidor.available();
  if (cliente != null) {
    while (cliente.available() > 0){
      String dado = cliente.readStringUntil(0x0A);
      if (dado != null) {
        String[] valores = dado.split(";");
        String clienteId = valores[0];
        float X = int(valores[1]);
        float Y = int(valores[2]);
        float raio = float(valores[3]);
        if (clientes.containsKey(clienteId)){
          clientes.put(clienteId, clientes.get(clienteId).atualizar(X, Y, raio));
        } else {
          clientes.put(clienteId, new Pincel(X, Y, raio));
        }
      } else {
        break;
      }
    };
  }
};