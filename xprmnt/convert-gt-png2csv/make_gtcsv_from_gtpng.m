clear all;
clc;

util_dir = '/home/tor/lab1231-sun-prj/util/src-m';
addpath(util_dir);

VOCcode_dir = '/home/tor/dataset/pascal/VOC2012/VOCdevkit/VOCcode';
addpath(VOCcode_dir);

%%
gt_png_dirpath = '/home/tor/dataset/pascal/VOC2010/VOCdevkit/VOC2010/SegmentationClass';
gt_csv_dirpath = '/home/tor/dataset/pascal/VOC2010/VOCdevkit/VOC2010/SegmentationClass-csv';
mkdir(gt_csv_dirpath);

%%
listing = dir(gt_png_dirpath);
counter = 0;
old_cmap = 0;
for i=1:numel(listing)
	if listing(i).isdir
		continue
	end
	
	%
	counter = counter + 1;
	fprintf('Processing %d/%d\n', counter, numel(listing)-2);

	png_filename = listing(i).name;
	png_filepath = strcat(gt_png_dirpath, '/', png_filename);

	csv_filename = strcat(png_filename(1:numel(png_filename)-4), '.csv');
	csv_filepath = strcat(gt_csv_dirpath, '/', csv_filename);

	cmap = make_csv_from_png_voc(png_filepath, csv_filepath);
    
    if counter > 1
        if ref_cmap ~= cmap
            error('unconsistent cmap');
        end
    end
    ref_cmap = cmap;
end

csvwrite('ref_cmap.csv',ref_cmap);