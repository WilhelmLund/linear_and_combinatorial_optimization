G=digraph(cap);
[s,t]=findedge(G);
plot(G,'XData',xpos,'YData',ypos,'EdgeLabel',G.Edges.Weight)
axis off
