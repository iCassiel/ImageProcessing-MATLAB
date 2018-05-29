function P2 = region_detect(Pr,Pc,img2,r)
local_region1 = zeros(2*r+1,2*r+1);
[m,n] = size(img2);
P2 = zeros(m,n);
for i1 = 1:length(Pr)
    for a = Pr(i1)-r:Pr(i1)+r
        for b = Pc(i1)-r,Pc(i1)+r
            local_region1 = img2(i1)/sum(sum(local_region1));
        end
    end
end