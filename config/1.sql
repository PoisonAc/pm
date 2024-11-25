CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('aluno', 'professor', 'admin') NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultima_atividade DATETIME,
    ativo BOOLEAN DEFAULT TRUE
);

	Tabela cursos

CREATE TABLE cursos (
    curso_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    professor_id INT,
    preco DECIMAL(10, 2) NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ativo', 'inativo', 'concluido') DEFAULT 'ativo',
    FOREIGN KEY (professor_id) REFERENCES usuarios(usuario_id) ON DELETE SET NULL
);

	Tabela inscricoes

CREATE TABLE inscricoes (
    inscricao_id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    data_inscricao DATETIME DEFAULT CURRENT_TIMESTAMP,
    progresso DECIMAL(5, 2) DEFAULT 0,
    data_conclusao DATETIME,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE
);

	Tabela pagamentos

CREATE TABLE pagamentos (
    pagamento_id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    valor_pago DECIMAL(10, 2) NOT NULL,
    metodo_pagamento ENUM('cartao', 'boleto', 'paypal', 'pix') NOT NULL,
    status_pagamento ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    data_pagamento DATETIME,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE
);

	Tabela chats

CREATE TABLE chats (
    chat_id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    professor_id INT,
    curso_id INT,
    data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_chat ENUM('ativo', 'finalizado') DEFAULT 'ativo',
    FOREIGN KEY (aluno_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE
);

	Tabela mensagens

CREATE TABLE mensagens (
    mensagem_id INT PRIMARY KEY AUTO_INCREMENT,
    chat_id INT,
    remetente_id INT,
    conteudo TEXT NOT NULL,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chats(chat_id) ON DELETE CASCADE,
    FOREIGN KEY (remetente_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE
);

	Tabela avaliacoes_cursos

CREATE TABLE avaliacoes_cursos (
    avaliacao_id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE
);

	Tabela certificados

CREATE TABLE certificados (
    certificado_id INT PRIMARY KEY AUTO_INCREMENT,
    inscricao_id INT,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    url_certificado VARCHAR(255),
    FOREIGN KEY (inscricao_id) REFERENCES inscricoes(inscricao_id) ON DELETE CASCADE
);

	Tabela administradores

CREATE TABLE administradores (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    nivel_acesso ENUM('superadmin', 'moderador') NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE
);
