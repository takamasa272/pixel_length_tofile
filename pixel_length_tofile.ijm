//作業ディレクトリの選択
showMessage("Select Open Folder");
dir = getDirectory("Choose Directory");
list = getFileList(dir); //作業ディレクトリの中にあるファイルのリスト

list_oib = Array.filter(list, ".oib");
list_oir = Array.filter(list, ".oir");
list_read = Array.concat(list_oib, list_oir); //.oirと.oibのみのリスト

// Create CSV content
csvContent = "filename,unit,width/pixel,height/pixel\n";
//main
for(j=0; j<list_read.length; ++j){
	name = list_read[j];
	extension = indexOf(name, "."); //拡張子(.を含む)
	namewithoutextension = substring(name, 0, extension); //元データは"namewithoutextension + extension"
	path = dir+name;
	
	run("Bio-Formats Importer", "open=path");
	
	// Extract pixel size information
	getPixelSize(unit, width, height, depth);
	
	//	// Display pixel size in microns
	//	Dialog.create("Width per pixel: " + width + " " + unit);
	//	Dialog.create("Height per pixel: " + height + " " + unit);
	
	csvContent += name + "," + unit + "," + width + "," + height + "\n";
	
	close(name); //元ファイルを閉じる

}


// Define the path for the CSV file
csvPath = dir + "pixel_length_ratio.csv";

// Save the CSV file
File.saveString(csvContent, csvPath);

Dialog.create("Finished");
Dialog.addMessage("All files have been successfully exported!");
Dialog.show;


