import processing.sound.*;

float sensibilidade = 1.0;
AudioIn mic;
Amplitude rms;

void confAudio(){
  // captura o audio
  mic = new AudioIn(this, 0);
  mic.start();
  mic.amp(sensibilidade);
  
  // cria um novo analizador de amplitude (rms)
  rms = new Amplitude(this);
  
  // conecta a entrada no analizador de amplitude
  rms.input(mic);
}

float amplitude(){
  return rms.analyze();
};