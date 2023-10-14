% 定义输入和输出文件夹路径
path1 = 'images/cover';  % 替换成实际的输入文件夹路径
path2 = 'images/stego'; % 替换成实际的输出文件夹路径

% 获取输入文件夹中的所有 PGM 文件列表
pgmFiles = dir(fullfile(path1, '*.pgm'));

% 设置 Payload
Payload = 0.4;

for i = 1:length(pgmFiles)
    % 读取图像
    Cover = double(imread(fullfile(path1, pgmFiles(i).name)));
    disp(pgmFiles(i).name);

    % MiPOD 嵌入
    [Stego, ~, ~] = MiPOD(Cover, Payload);
    
    % 首先，交换行列以匹配 PGM 文件格式
    Stego = Stego';
    
    % 构建输出文件路径
    outputFilePath = fullfile(path2, pgmFiles(i).name);
    
    % 打开一个文件用于写入
    fid = fopen(outputFilePath, 'wb');
    
    % 写入 PGM 头信息
    fprintf(fid, 'P5\n');
    fprintf(fid, '%d %d\n', size(Stego, 2), size(Stego, 1));
    fprintf(fid, '255\n');
    
    % 将图像数据以二进制形式写入
    fwrite(fid, Stego, 'uint8');
    
    % 关闭文件
    fclose(fid);

end

