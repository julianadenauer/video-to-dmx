class PixelBox {
  public int x, y, length;
  public color c;
  public int dmxStartChannel;

  public boolean paletize = true;

  private color palett[] = {
    #f5d765, #f02a27, #921b1d, #a64c28, #e0c678, #694e4e, #4f403f, #5c5449, #9e8371, #80514a, #8b6748, #6e2233, #7c4749, #6e2f49, #824a86, #ac7bb0, #cab2cc, #e7dee8, #e5d7cb, #e5dec7, 
    #ede9da, #c1b89a, #e1e4c9, #e9eae0, #8f8f5c, #b6b6a0, #76a08b, #54a47f, #498e61, #7dd89d, #66c1c2, #4183b9, #3854c6, #3355a0, #0d3ba1, #052a7f, #3a6792, #0d375e, #093a67, #42336c,
    #2c1768, #241256, #4b4b41, #bfcfbe, #dee8dd, #e6e8e6, #cbd8de, #cce9f6, #d5e0e5, #c3d8f4, #b9cac6, #c8dee2, #e3e6e6, #f7fafb, #f6f7ee, #edeee8, #f0f2e3, #ebece5, #dfe4e5, #ebebeb, 
    #c7c3a2, #b0a68d, #d0cab0, #92948d, #5c5b51, #413f32, #878783, #70706c, #868681, #233327, #4a4731, #493232, #503535, #583b4b, #292627, #241f22, #070707
  };
  
  public int getX(){return x;}
  public int getY(){return y;}
  
  public PixelBox(int x, int y, int length, int dmxStartChannel){
    this.x = x;
    this.y = y;
    this.length = length;
    this.dmxStartChannel = dmxStartChannel;
  }
  
  public void moveTo(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void draw(int offsetX, int offsetY){
    fill(c);
    stroke(204, 102, 0);
    rect(x + offsetX, y + offsetY, length, length); 
  } 
  
  public void update(Movie mov){
    long sumR = 0;
    long sumG = 0;
    long sumB = 0;
    
    for (int j = y; j < y + length; j++) {
      for (int i = x; i < x + length; i++) {            
        sumR += (long) red(mov.get(i, j));
        sumG += (long) green(mov.get(i, j));
        sumB += (long) blue(mov.get(i, j));
      }
    }

    c = color(sumR/sq(length), sumG/sq(length), sumB/sq(length));  
    if (paletize){
      c = getClosestColorCieLAB(c);
    }
  }

  private color getClosestColorCieLAB(color c){
    CieLAB c1 = new CieLAB(c); 
    
    float minDistance = 1000.0;
    int minDistanceIndex = 0;
    for(int i = 0; i< palett.length; i++){
      CieLAB c2 = new CieLAB(palett[i]);
      float distance = c1.getDistance(c2);
      if(distance < minDistance){
        minDistanceIndex = i;
        minDistance = distance;
      }
    }
    return palett[minDistanceIndex];
  }
};
