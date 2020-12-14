using CSV
using DataFrames
df = DataFrame(Name = ["Cidade 1","Cidade 2","Cidade 3","Cidade 4","Cidade 5"], 
               Latitude = [23,2323,232323,23232323,2323232323],
               Longitude = [2,2,2,2,2]
               )
##Cria o DataFrame
CSV.write("C:\\export_df.csv", df)
##Escreve a variável df como um arquivo CSV dentro do pathing que você escolheu no computador
using CSV
using DataFrames
CSV.read("C:\\export_df.csv", DataFrame)
##Lê o arquivo CSV que está salvo no path
CSV.File("C:\\export_df.csv"; normalizenames=true)
#normaliza os nomes
f = CSV.File("C:\\export_df.csv")
#Declara a variável f como sendo o conteúdo do arquivo

dist = (ones(length(f), length(f)))
for i in 1:length(f) 
    for j in 1:length(f) 
        dist[i,j] = sqrt((f[i][2] - f[j][2])^2 + (f[i][3] - f[j][3])^2)  ##fórmula da distância no plano
    end
end
dist
x = 0
MatrizRota = []
Rota = [0]
RotaNome = []
for i in 1:length(f)
    for j in 1:length(f)
        if dist[i,j] == 0
            dist[i,j] = 2^63-1 
	##Caso a entrada i,j da matriz distância for zero, eu troco o valor para um valor grande.
        end
    end
end
###código acima deixou todas as distâncias de uma cidade até ela mesma como um número anterior ao Overflow, assim, o programa não pegará a distância de uma cidade até ela mesma 
y = []
for i in 1:length(f) - 1        
    x = minimum(dist[1:length(f),i])
    for j in 1:length(f)
        for k in 1:length(RotaNome)
            for l in 1:length(f)
                if x == Rota[k]
                    dist[j,l] = 2^63-1
                    ##caso a distância x já esteja dentro do vetor Rotas, eu troco dist[k,l] para valores grandes
                end
                x = minimum(dist[1:5,i])
            end
        end
            if x == dist[i,j]
                y = "Caminho = Cidade$(i)$(j)"
            end        
    end
    RotaNome = push!(RotaNome,y )
    Rota = push!(MatrizRota,x)
    RotaNome = String.(RotaNome)
    Rota = Float64.(Rota)
end
println("Distâncias rota = $Rota, Cidades rota = $RotaNome")
