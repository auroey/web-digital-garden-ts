---
title: VAE, Variational Autoencoder
date: 2025-08-11
---
[[GAI,Generative AI]]

[Fetching Title#f6iu](https://lilianweng.github.io/posts/2018-08-12-vae/)
### VAE

https://adaning.github.io/posts/9047.html

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=NDJjNTdiOWJjYTQ0MWE5YTg1MjE0MTM0MjU3MGIyOWZfRDh1YTQ1MFhvOE45YWlRMWFHT0hGWWJGbkJVRXJhV09fVG9rZW46SEptdGJUbkpBb3NDOHl4NEpEbGNtb2phblBjXzE3NTUwNTQ4MDc6MTc1NTA1ODQwN19WNA)

x_n是**一个输入数据**的第n个维度的信息表示，a是权重，miu和sigma合在一起共同表示一个压缩后的维度。解压缩的过程是以z_n为参数盲猜output各个维度，这个盲猜的路径由训练好的a决定。

Feedforward Neural Network (FNN)：forward

Fully Connected Neural Network (FCNN)：Fully Connected

Multilayer Perceptron (MLP)：Multilayer + Fully Connected

Deep Neural Network (DNN)：Multilayer

AutoEncoder：输出x`

![](https://pq01uwab7j.feishu.cn/space/api/box/stream/download/asynccode/?code=ODk5M2RiZjQyMzMyNDNkZDc3MDM1N2UzM2QyZTZmYzZfTXE5WWZoekhDSVRuQnk0RjV6NjVqcEpVSWI2UTJXMDJfVG9rZW46T01EcGJJcWRTbzYydGN4OFNka2M2NkZ0blAzXzE3NTUwNTQ4MDc6MTc1NTA1ODQwN19WNA)

  

#### 代码

  

```Python
latent_dim = 2 # x`个数
input_dim = 28 * 28 # x个数
inter_dim = 256 # 过渡层神经元个数

class VAE(nn.Module):
    def __init__(self, input_dim=input_dim, inter_dim=inter_dim, latent_dim=latent_dim):
        super(VAE, self).__init__() #用来初始化

        self.encoder = nn.Sequential(
            nn.Linear(input_dim, inter_dim),#如[64, 784]，64是图片数量，784是每张图片的信息量、特征数
            nn.ReLU(),#dim不变，值被映射
            nn.Linear(inter_dim, latent_dim * 2),#每个z由两个变量控制
        )#encoder定义

        self.decoder =  nn.Sequential(
            nn.Linear(latent_dim, inter_dim),
            nn.ReLU(),
            nn.Linear(inter_dim, input_dim),
            nn.Sigmoid(),
        )

        # Reparameterization Trick
    def reparameterize(self, mu, logvar):
        epsilon = torch.randn_like(mu) # ε ~ N(0, 1)，生成和 mu 形状一样的张量
        return mu + epsilon * torch.exp(logvar / 2) # mu形状的z，z ~ N(mu, sigma^2)

    def forward(self, x):
        org_size = x.size()#原始形状
        batch = org_size[0]#批量
        x = x.view(batch, -1)#批量 x 各种维度参数

        h = self.encoder(x)# 调用encoder方法，得到两个变量形式的z
        mu, logvar = h.chunk(2, dim=1)#把第一维的特征分成两类
        z = self.reparameterize(mu, logvar)
        recon_x = self.decoder(z).view(size=org_size)#按照org_size reshape

        return recon_x, mu, logvar
```

  

##### Loss

  

相似度：KL散度+**重构损失**

  

[[BCE, binary cross-entropy]]：每个像素Binary判定

  

Mean Squared Error（MSE）：每个像素预测值和真实值的真实连续值的平均值

  

```Python
kl_loss = lambda mu, logvar: -0.5 * torch.sum(1 + logvar - mu.pow(2) - logvar.exp())
recon_loss = lambda recon_x, x: F.binary_cross_entropy(recon_x, x, size_average=False)
```

  

##### Training

  

transforms.ToTensor()：

  

PIL.Image / numpy.ndarray -> torch.FloatTensor

  

像素值从 `[0, 255]` 映射到 `[0.0, 1.0]`

  

通道顺序从 `(H, W, C)` 变成 `(C, H, W)`

  

`transforms.Compose([...])`:

  

表示多个图像预处理步骤**按顺序组合**起来

  

定义：

```Python
epochs = 100
batch_size = 128#每次训练使用 128 张图片做一次梯度更新（调整参数。在每一轮训练中，根据误差的导数（梯度）调参后，继续下个epoch计算）

#load dataset
transform = transforms.Compose([transforms.ToTensor()])
data_train = MNIST('MNIST_DATA/', train=True, download=False, transform=transform)
data_valid = MNIST('MNIST_DATA/', train=False, download=False, transform=transform)

# 用 DataLoader 将数据打包成小 batch
train_loader = DataLoader(data_train, batch_size=batch_size, shuffle=True, num_workers=0) #主进程
test_loader = DataLoader(data_valid, batch_size=batch_size, shuffle=False, num_workers=0)

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

model = VAE(input_dim, inter_dim, latent_dim)
model.to(device)
optimizer = optim.Adam(model.parameters(), lr=1e-3)#优化器：依据学习率在每轮调整可训练参数的方法
```

  

执行训练：

  

```Python
best_loss = 1e9
best_epoch = 0

valid_losses = []
train_losses = []

for epoch in range(epochs):
    print(f"Epoch {epoch}")
    model.train()# 启用 Dropout 和 BatchNorm 的“训练行为”
    train_loss = 0.
    train_num = len(train_loader.dataset)

    for idx, (x, _) in enumerate(train_loader):
        batch = x.size(0)
        x = x.to(device)
        recon_x, mu, logvar = model(x)
        recon = recon_loss(recon_x, x)
        kl = kl_loss(mu, logvar)

        loss = recon + kl#当前这个 batch 的多个样本的总损失
        train_loss += loss.item()#由tensor变float后计算整个epoch的总损失
        loss = loss / batch#每个epoch的平均损失

        optimizer.zero_grad()#梯度归零
        loss.backward()#计算损失对所有模型参数的梯度
        optimizer.step()#更新参数

        if idx % 100 == 0:
            print(f"Training loss {loss: .3f} \t Recon {recon / batch: .3f} \t KL {kl / batch: .3f} in Step {idx}")

    train_losses.append(train_loss / train_num)

    valid_loss = 0.
    valid_recon = 0.
    valid_kl = 0.
    valid_num = len(test_loader.dataset)
    model.eval()# 关闭 Dropout，使用固定的 BatchNorm 均值方差
    with torch.no_grad():
        for idx, (x, _) in enumerate(test_loader):
            x = x.to(device)
            recon_x, mu, logvar = model(x)
            recon = recon_loss(recon_x, x)
            kl = kl_loss(mu, logvar)
            loss = recon + kl
            valid_loss += loss.item()
            valid_kl += kl.item()
            valid_recon += recon.item()

        valid_losses.append(valid_loss / valid_num)

        print(f"Valid loss {valid_loss / valid_num: .3f} \t Recon {valid_recon / valid_num: .3f} \t KL {valid_kl / valid_num: .3f} in epoch {epoch}")

        if valid_loss < best_loss:
            best_loss = valid_loss
            best_epoch = epoch

            torch.save(model.state_dict(), 'best_model_mnist')
            print("Model saved")
```

  

VAE 编解码视频

  

1. https://arxiv.org/abs/2104.10157：将视频看作多帧图片
    

  

每帧输入encoder得到z后，用时序模型Transformer对序列建模，输出改进后的序列，最后Decode每个z

  

2. 或直接用3D Encoder和Decoder处理