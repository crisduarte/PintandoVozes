int hsb_mode = 255;

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
    this.matiz = random(hsb_mode);
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