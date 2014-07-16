class PixelBoxArray{
	private ArrayList<PixelBox> boxes;

	private int numBoxes = 0;
	private int numChannelsPerBox = 4;
	private int dmxStartChannel = 0;

	private boolean recording = false;
	private PrintWriter output;

	public PixelBoxArray() {
		boxes = new ArrayList<PixelBox>();
	}

	public void generate(int numX, int numY, int offsetX, int offsetY, int length){
  		for(int i = 0; i<numY; i++){
    		for(int j = 0; j < numX; j++){
      			add(offsetX + (j*length), offsetY + (i*length), length);
    		}
  		}
	}

	public void add(int x, int y, int length){
		numBoxes++;
		boxes.add(new PixelBox(x, y, length, numBoxes * numChannelsPerBox + dmxStartChannel));
		println("added box #", numBoxes, " with start channel ", (numBoxes-1) * numChannelsPerBox + dmxStartChannel);
	}

	public void draw(){
		for(PixelBox box : boxes){
      		box.draw(0, 0);
    	}  
	}

	public void draw(int xOffset, int yOffset){
		for(PixelBox box : boxes){
      		box.draw(xOffset, yOffset);
    	}  
	}

	public void update(Movie mov){
		for(PixelBox box : boxes){
      		box.update(mov);

      		if(recording){
      			output.print((int)red(box.c) + "\t" + (int)green(box.c) + "\t" + (int)blue(box.c) + "\t");

      			// this ignores the dmx channel setting of the individual pixels. this is probably ok for this time
      			// normally the following should be done
      			// 1. go through all boxes and detect the last index
      			// 2. make an array with length of the last index + dmxwidth. then fill it with zeros.
      			// 3. go through the boxes. fill the values in the right colums.
      			// 4. write the array into the file      			
      		}
    	}
    	if(recording) output.println();
	}

	public void startRecording(){
		output = createWriter("output.txt"); 
		recording = true;
	}

	public void stopRecording(){
		output.flush(); // Writes the remaining data to the file
  		output.close(); // Finishes the file
  		recording = false;
	}
};

