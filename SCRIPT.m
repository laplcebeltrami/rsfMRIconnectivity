%% The script load rs-fMRI correlation brain network data generated from the study
% The raw rs-fMRI went though the processing steps (only motion correction,
% bandpass filtering) described in 
%
% [1] Huang, S.-G., Samdin, S.B., Ting, C.M., Ombao, H., Chung, M.K. 2020
% Statistical model for dynamically-changing correlation matrices 
% with application to brain connectivity. Journal of Neuroscience Methods 331:108480
% http://pages.stat.wisc.edu/~mchung/papers/huang.2020.NM.pdf
%
% The data is further used in studies
%
% [2] Chung, M.K., El-Yaagoubi,A.B., Qiu, A., Ombao, H. 2025 
% From Density to Void: Why Brain Networks Fail to Reveal Complex Higher-Order 
% Structures, arXiv:2503.14700
% https://arxiv.org/abs/2503.14700
%
% [3] Songdechakraiwut, T., Chung, M.K., 2023 Topological learning for brain networks
%  The annals of applied statistics 17: 403-433
%  https://par.nsf.gov/servlets/purl/10478240
%
% [4] Anand,D.V., Chung, M.K., 2023 Hodge Laplacian of brain 
% networks, IEEE transactions on medical imaging 42:1563-1573
% https://arxiv.org/abs/2110.14599
% 
%% If you are using the data, reference one of these papers.
%
% (C) 2021 Moo K. Chung  mkchung@wisc.edu
%     University of Wisconsin-Madison
%     
% Created June 07, 2021, 
% Updated Oct 12, 2021; June 29, 2024; Apri 7, 2025
%
%
%% ------------------------------
%% Part I. Static summary correlation matrix per subject
load rsfMRIconnectivity.mat 

save rsfMRIconnectivity.mat Conn age sex
Conn=single(Conn);

% The data contains age and sex information:
%   Age in years
%   Sex (1 for Male, 0 for Female)
%
% Conn: 400 subject connectivity matrices over 
% 6670 = 116 x (116-1)/2 edges. This is static summary 
% over whole time points. They are Pearson correlation of 
% whole time points over 116 AAL parcellations. 

figure; imagesc(Conn); colormap('hot')
xlabel('Correlations over edges')
ylabel('Subject index')
title('Functional brain connectivity')

%make functional data defined on edges into matrix form for the 4th subject
B=triu(ones(116),1); %upper triangle above the 1st diagonal (without the main diagonal).
B(B==1) = Conn(4,:); %subject 4
figure; imagesc(B'); %displaying the correlation matrix of the time point 100. 
figure_bigger(20); colormap('hot'); caxis([-1 1])
axis square; axis on; box off
colorbar('southoutside')

%% -------------------
%% Part II. These rs-fMRI connectivies are obtained for following brain regions.
%% AAL parcellation with 116 nodes
%
% (C) 2021 Moo K. Chung  mkchung@wisc.edu
%     University of Wisconsin-Madison
%     
% Created 2021 Jun 07
% Edited  2021 Dec 20/ 2024 July 02

load('t.mat') % load white matter brain surface template. 

%t = 
%  struct with fields:
%       faces: [21178×3 double]
%    vertices: [10436×3 double]
%       nodes: [116×3 double]

figure; figure_patch(t, [.9 .9 .9], .05);
view([-90 90]); alpha(0.3); camlight

%% AAL parcellation names
% ROI.Nom_L display brain region name. For left-right symmetry analysis, you have to compare the same name with
% _L and _R. For instance, the left region of precentral and the right
% region of precentral areas should be compared. This has to be manually
% identified. 
% Excluding the 8 vermis regions (i.e. the last 4 pairs), 

load('AAL-label.mat') %Anatomical names of 116 parcellations of the brain
a={ROI.Nom_L}; %choose either Nom_C or Nom_L
b=strrep(a, '_', '-');

%% AAL parcellation center
figure; figure_patch(t, [0.99216, 0.91765, 0.79608], 0.5);
view([-90 90]); alpha(0.3); camlight
% Nodes
hold on; scatter3(t.nodes(:,1), t.nodes(:,2), t.nodes(:,3), 100, 'filled'); % 100 is the size of the spheres

%% AAL parcellation labels
for i = 1:length(t.nodes)
    text(t.nodes(i, 1), t.nodes(i, 2), t.nodes(i, 3), b{i}, 'FontSize', 8, 'Color', 'k');
end











