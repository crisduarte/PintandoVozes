import processing.net.*;
import java.util.Map;

int porta_servidor = 5204;

Server servidor;
Map<String, Pincel> clientes;

void setup(){
  size(1024, 768);
  colorMode(HSB, hsb_mode);
  background(0);
  
  servidor = new Server(this, porta_servidor);
  clientes = new HashMap<String, Pincel>();
  
  println("Endereço do servidor: " + Server.ip() + ":" + porta_servidor);
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
        float matiz = float(valores[4]);
        if (clientes.containsKey(clienteId)){
          clientes.put(clienteId, clientes.get(clienteId).atualizar(X, Y, raio, matiz));
        } else {
          clientes.put(clienteId, new Pincel(X, Y, raio, matiz));
        }
      } else {
        break;
      }
    };
  }
};