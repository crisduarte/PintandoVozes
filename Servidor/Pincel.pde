int hsb_mode = 255;

class Pincel{
  public float X;
  public float Y;
  public float raio;
  public float matiz;
  
  Pincel(float X, float Y, float raio, float matiz){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    this.matiz = matiz;
  };
  
  public Pincel atualizar(float X, float Y, float raio, float matiz){
    this.X = X;
    this.Y = Y;
    this.raio = raio;
    this.matiz = matiz;
    this.pintar();
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
    fill(color(this.matiz - this.alturaRelativa(76, -38), hsb_mode - this.alturaRelativa(hsb_mode), hsb_mode - pow(this.alturaRelativa(), 2) * hsb_mode), 7);
    ellipse(this.X, this.Y, this.raio, this.raio);
    popStyle();
  };
};