class CieLAB {
  public float l, a, b;
  
  public CieLAB(){};
  public CieLAB(color c){
    // TO XYZ according to here: http://www.easyrgb.com/index.php?X=MATH&H=02#text2
    float var_R = ( red(c) / 255.0 );        //R from 0 to 255
    float var_G = ( green(c) / 255.0 );        //G from 0 to 255
    float var_B = ( blue(c) / 255.0 );        //B from 0 to 255
  
    if ( var_R > 0.04045 ) 
      var_R = pow(( ( var_R + 0.055 ) / 1.055 ), 2.4);
    else                   
      var_R = var_R / 12.92;
    if ( var_G > 0.04045 ) 
      var_G = pow(( ( var_G + 0.055 ) / 1.055 ),2.4);
    else                   
      var_G = var_G / 12.92;
    if ( var_B > 0.04045 ) 
      var_B = pow(( ( var_B + 0.055 ) / 1.055 ), 2.4);
    else
      var_B = var_B / 12.92;
    
    var_R *= 100;
    var_G *= 100;
    var_B *= 100;
    
    //Observer. = 2°, Illuminant = D65
    float x = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805;
    float y = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722;
    float z = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505;
        
    // from XYZ to CIE-L*ab
    float ref_X =  95.047;
    float ref_Y = 100.000;
    float ref_Z = 108.883;
    
    float var_X = x / ref_X;          // Observer= 2°, Illuminant= D65
    float var_Y = y / ref_Y;         //
    float var_Z = z / ref_Z;          //
    
    if ( var_X > 0.008856 ) var_X = pow(var_X,1.0/3.0);
    else                    var_X = ( 7.787 * var_X ) + ( 16.0 / 116.0 );
    if ( var_Y > 0.008856 ) var_Y = pow(var_Y,1.0/3.0 );
    else                    var_Y = ( 7.787 * var_Y ) + ( 16.0 / 116.0 );
    if ( var_Z > 0.008856 ) var_Z = pow(var_Z,1.0/3.0 );
    else                    var_Z = ( 7.787 * var_Z ) + ( 16.0 / 116.0 );
    
    this.l = ( 116.0 * var_Y ) - 16.0;
    this.a = 500 * ( var_X - var_Y );
    this.b = 200 * ( var_Y - var_Z );
  } 
  
  public float getDistance(CieLAB b){
    float differences = floatDistance(this.l, b.l) + floatDistance(this.a, b.a) + floatDistance(this.b, b.b);
    return sqrt(differences);
  }

  private float floatDistance(float a, float b){
    return (a - b) * (a - b);
  }
  
};
