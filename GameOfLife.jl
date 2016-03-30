# Conway's Game of Life in Julia Language 
#License: GPLv3
#Date: 2016-03-30
#Usage 
#julia GameOfLife.py n n_iter m
# where:
# n is the board size 
# n_iter the initial number of iterations
# m is 1 to plot the board or 0 for no graphical output 
using PyCall
@pyimport matplotlib.pyplot as plt
const n = int(ARGS[1])
n_iter = int(ARGS[2])
const m = int(ARGS[3])
function life_game(n,M,n_iter)
    for k=1:n_iter
        C = copy(M) # copy current life grid
        for i=1:n, j=1:n
            if (i==1) 
                i_left=n 
            else 
                i_left=i-1 
            end
            if(i==n)
                i_right=1; 
            else
                i_right=i+1;
            end
            if(j==1) 
                j_down=n; 
            else 
                j_down=j-1;
            end
            if(j==n)
                j_up=1; 
            else 
                j_up=j+1;
            end
            count = C[i_left,j] + C[i_left,j_up] + C[i_left,j_down] + C[i,j_down] + C[i,j_up] + C[i_right,j] + C[i_right,j_up] + C[i_right,j_down] 
            if C[i, j]==1
                if count < 2 || count > 3
                    M[i, j] = 0 # living cells with <2 or >3 neighbors die
                end
            elseif count == 3
                M[i, j] = 1 # dead cells with 3 neighbors are born
            end
        end
    end
    return M
end
M0=rand(0:1,n,n) # Initialize with a random pattern
M=life_game(n,M0,n_iter)
print(sum(M)," live cells after ",n_iter," iterations\n")
if m != 0
    fig = plt.figure(figsize=(12,12))
    plt.gray()
    while m != 0
        M1=abs(1-M)
        plt.imshow(M1,  interpolation="none")
        plt.title("Conway's Game of Life, $n_iter Iterations")
        plt.pause(.01) 
        #print(" k=",n_iter," live cells=",sum(M),"\n")
        M=life_game(n,M,1) 
        n_iter=n_iter+1

    end
end
