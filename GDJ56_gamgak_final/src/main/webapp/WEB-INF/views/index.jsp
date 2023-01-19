<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- ��Ʈ��Ʈ�� css/js -->
    <link href="./bootstrap-5.2.3-dist/css/bootstrap.css" rel="stylesheet">
    <script src="./bootstrap-5.2.3-dist/js/jquery-3.6.1.min.js"></script>
    <!-- index css -->
    <link href="./bootstrap-5.2.3-dist/css/index.css" rel="stylesheet">
    <!-- Font Awesome icons (free version)-->
    <script src="https://kit.fontawesome.com/d87d902b0c.js" crossorigin="anonymous"></script>
</head>
<body>
    <div id="basic-wrapper">
        <!-- MainImageCarousel -->
        <div id="carouselExampleCaptions" class="carousel slide col-sm-6" data-bs-ride="false">
            <div class="carousel-indicators">
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="./img/�ӽ� �̹���02.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>First slide label</h5>
                  <p>Some representative placeholder content for the first slide.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="./img/�ӽ� �̹���02.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Second slide label</h5>
                  <p>Some representative placeholder content for the second slide.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="./img/�ӽ� �̹���02.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Third slide label</h5>
                  <p>Some representative placeholder content for the third slide.</p>
                </div>
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>
          <!-- Login -->
        <div id="login-wrapper" class="col-sm-6">
            <img id="logo-img" src="./img/2-1.png" >
            <h3>��:��</h3>
            <h6>������ ���� ���</h6>
            <div id="loginInput">
                <div id="rowLine"></div>
                <div id="inputId" class="form-floating mb-3">
                    <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
                    <label for="floatingInput">Email address</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="floatingPassword" placeholder="Password">
                    <label for="floatingPassword">Password</label>
                </div>
                <button id="loginButton" type="button" class="btn btn-danger">�α���</button>
                <a><img id="kakaologin" src="./img/īī�� �α���.png"/></a>
                <div id="loginEtc">
                    <a><span>ȸ������</span></a>
                    <div id="colLine"></div>
                    <a><span>���̵� ã��</span></a>
                    <div id="colLine"></div>
                    <a><span>��й�ȣ ã��</span></a>
                </div>
                <div id="rowLine"></div>
            </div>


            <!-- Footer -->
            <footer>
                <div>
                    <span>�޴�</span>
                    <span>�޴�</span>
                    <span>�޴�</span>
                    <span>�޴�</span>
                    <span>�޴�</span>
                    <span>�޴�</span>
                    <span>�޴�</span>
                </div>
                <p>
                    &copy;2023 Gamgak from LDH
                </p>
            </footer>
        </div>
     </div>

    <!-- ��Ʈ��Ʈ�� js -->
    <script src="./bootstrap-5.2.3-dist/js/bootstrap.js"></script>
    <script>

    </script>
</body>
</html>