function val = odsekoma_linearna(x, delilne_tocke, j)
    val = 0;
    if j == 1
        if (delilne_tocke(1) <= x) & (x <= delilne_tocke(2))
            val = (delilne_tocke(j + 1) - x) / (delilne_tocke(j + 1) - delilne_tocke(j));
        end
    else
        if j == length(delilne_tocke)
            if (delilne_tocke(j - 1) <= x) & (x <= delilne_tocke(j))
                val = (x - delilne_tocke(j - 1)) / (delilne_tocke(j) - delilne_tocke(j - 1));
            end
        else
            if (delilne_tocke(j - 1) <= x) & (x <= delilne_tocke(j))
                val = (x - delilne_tocke(j - 1)) / (delilne_tocke(j) - delilne_tocke(j - 1));
            elseif (delilne_tocke(j) < x) & (x <= delilne_tocke(j + 1))
                val = (delilne_tocke(j + 1) - x) / (delilne_tocke(j + 1) - delilne_tocke(j));
            end
        end
    end
end