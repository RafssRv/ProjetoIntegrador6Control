CREATE TABLE IF NOT EXISTS tarefas (
    id SERIAL PRIMARY KEY,
    fase INTEGER NOT NULL,
    fase_label TEXT NOT NULL,
    fase_sub TEXT NOT NULL,
    fase_titulo TEXT NOT NULL,
    fase_desc TEXT NOT NULL,
    pessoa TEXT NOT NULL,
    descricao TEXT NOT NULL,
    guia TEXT,
    concluida BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO tarefas (fase, fase_label, fase_sub, fase_titulo, fase_desc, pessoa, descricao, guia) VALUES

(1, 'Fase 1', 'Semanas 1-3', 'Fundação isolada', 'Cada pessoa constrói sua parte de forma independente, sem integração ainda.', 'Roveris', 'Script Whisper + LLM + Piper em sequência, arquivo entra, arquivo sai',
'Objetivo: provar que as três peças conversam entre si, sem se preocupar com tempo real ainda.

1. Instale o faster-whisper (pip install faster-whisper), é a versão otimizada do Whisper, mais rápida que a original em CPU.
2. Instale o Ollama separadamente (não é pacote pip, é um programa), baixe o modelo com ollama pull llama3.2:3b.
3. Instale o Piper (pip install piper-tts) e baixe a voz pt_BR-cadu-medium no repositório oficial do projeto.
4. Escreva um script que faz, em sequência: lê um arquivo .wav de teste, manda pro faster-whisper e imprime o texto transcrito, manda esse texto pro Ollama via biblioteca ollama e imprime a resposta, manda a resposta pro Piper e salva um novo .wav.
5. Não se preocupe com streaming nem latência aqui, o objetivo é só confirmar que os três modelos rodam na sua máquina e produzem saída coerente.'),

(1, 'Fase 1', 'Semanas 1-3', 'Fundação isolada', 'Cada pessoa constrói sua parte de forma independente, sem integração ainda.', 'Nonato', 'Primeira versão do prompt, testando direto no chat do Ollama',
'Objetivo: descobrir que instruções fazem o modelo se comportar como atendente, antes de programar nada.

1. Rode ollama run llama3.2:3b no terminal, isso abre um chat interativo direto com o modelo.
2. Escreva um system prompt inicial descrevendo o papel do agente, tom de atendimento, e o que ele deve fazer (ex: "você é um atendente de pizzaria, seja educado e direto, pergunte o nome e CPF do cliente no início").
3. Teste conversas simuladas digitando como se fosse o cliente, veja se o modelo mantém o personagem e não sai do personagem no meio da conversa.
4. Anote os problemas que aparecerem, tipo o modelo inventando produtos que não existem no cardápio, isso vira material pra Fase 3.'),

(1, 'Fase 1', 'Semanas 1-3', 'Fundação isolada', 'Cada pessoa constrói sua parte de forma independente, sem integração ainda.', 'Arthur', 'FastAPI rodando, endpoint de teste',
'Objetivo: ter um servidor web básico de pé, que a Anderson e o Roveris vão eventualmente chamar.

1. Instale com pip install fastapi uvicorn.
2. Crie um arquivo main.py com uma rota simples, tipo GET /health que retorna {"status": "ok"}.
3. Rode com uvicorn main:app --reload e acesse http://localhost:8000/health no navegador pra confirmar que responde.
4. Familiarize-se com a documentação automática do FastAPI em /docs, ela ajuda bastante a testar endpoints sem precisar escrever um cliente.'),

(1, 'Fase 1', 'Semanas 1-3', 'Fundação isolada', 'Cada pessoa constrói sua parte de forma independente, sem integração ainda.', 'Chefe', 'Tabelas criadas: Cliente, Produto, Pedido, ItemPedido',
'Objetivo: ter a estrutura do banco pronta, mesmo que ainda sem dado real nem conexão com o resto do sistema.

1. Defina as colunas de cada tabela, um ponto de partida razoável: Cliente (id, nome, cpf, telefone), Produto (id, nome, preço), Pedido (id, cliente_id, data, status), ItemPedido (id, pedido_id, produto_id, quantidade).
2. Use SQLAlchemy (pip install sqlalchemy psycopg2-binary) pra definir isso como classes Python, facilita integrar com o FastAPI depois.
3. Rode a criação das tabelas num banco Postgres local ou Neon, e confirme com um cliente de banco (DBeaver, ou a própria extensão do Postgres no VS Code) que as tabelas existem com as colunas certas.
4. Ainda não precisa de dado de verdade nem de lógica de negócio, só a estrutura.'),

(1, 'Fase 1', 'Semanas 1-3', 'Fundação isolada', 'Cada pessoa constrói sua parte de forma independente, sem integração ainda.', 'Anderson', 'Protótipo gravando e tocando áudio no navegador',
'Objetivo: confirmar que dá pra capturar voz do microfone do celular pelo navegador, sem depender de app nativo.

1. Use a API nativa do navegador MediaRecorder, não precisa de biblioteca externa pra isso.
2. Peça permissão de microfone com navigator.mediaDevices.getUserMedia({ audio: true }).
3. Grave um trecho curto, pare a gravação, e toque de volta com um elemento <audio>, só pra confirmar que o ciclo captura, grava e reproduz funciona no celular.
4. Teste especificamente no navegador do celular (Chrome Android ou Safari iOS), o comportamento de permissão de microfone varia entre eles.'),


(2, 'Fase 2', 'Semanas 4-6', 'Integração fim a fim mínima', 'Meta única e inegociável: alguém fala no navegador e ouve resposta de volta. Feio, lento, sem banco.', 'Roveris', 'Pipeline plugado no backend, sem streaming, requisição simples',
'Objetivo: transformar o script solto da Fase 1 numa função que o backend consegue chamar.

1. Empacote a Fase 1 como uma função única, tipo processar_audio(caminho_arquivo) -> caminho_audio_resposta, sem preocupação com performance ainda.
2. Combine com a Arthur qual vai ser essa assinatura antes de codar, isso evita retrabalho quando ela for plugar no endpoint.
3. Teste a função isoladamente antes de entregar pra integração, chamando ela direto num script Python simples com um arquivo de teste.'),

(2, 'Fase 2', 'Semanas 4-6', 'Integração fim a fim mínima', 'Meta única e inegociável: alguém fala no navegador e ouve resposta de volta. Feio, lento, sem banco.', 'Arthur', 'Endpoint que recebe áudio do frontend, chama o pipeline, devolve áudio',
'Objetivo: ligar o frontend ao pipeline de voz através de uma rota HTTP.

1. Crie uma rota POST que aceita upload de arquivo (FastAPI usa UploadFile pra isso).
2. Salve o arquivo recebido temporariamente em disco, chame a função do Roveris passando esse caminho.
3. Devolva o arquivo de áudio de resposta como resposta HTTP (FileResponse do FastAPI serve pra isso).
4. Teste a rota isoladamente primeiro com uma ferramenta tipo Postman ou Insomnia, mandando um .wav de teste, antes de esperar o frontend estar pronto.'),

(2, 'Fase 2', 'Semanas 4-6', 'Integração fim a fim mínima', 'Meta única e inegociável: alguém fala no navegador e ouve resposta de volta. Feio, lento, sem banco.', 'Anderson', 'Frontend mandando áudio pro backend e tocando a resposta',
'Objetivo: fechar o ciclo completo do lado do navegador.

1. Pegue o áudio gravado pelo MediaRecorder (Fase 1) e mande via fetch com FormData pro endpoint da Arthur.
2. Espere a resposta (que vem como arquivo de áudio), transforme em Blob, crie uma URL local com URL.createObjectURL, e toque num elemento <audio>.
3. No celular, teste o fluxo completo: gravar, soltar o botão, esperar, ouvir a resposta.'),

(2, 'Fase 2', 'Semanas 4-6', 'Integração fim a fim mínima', 'Meta única e inegociável: alguém fala no navegador e ouve resposta de volta. Feio, lento, sem banco.', 'Chefe', 'Segue em paralelo no banco, sem bloquear a integração',
'Objetivo: continuar avançando a modelagem sem esperar a integração ficar pronta.

Use esse período pra já pensar em como o histórico de pedidos vai ser consultado (Fase 4), e deixar queries de exemplo prontas, mesmo que ainda sem conectar no fluxo real.'),

(2, 'Fase 2', 'Semanas 4-6', 'Integração fim a fim mínima', 'Meta única e inegociável: alguém fala no navegador e ouve resposta de volta. Feio, lento, sem banco.', 'Nonato', 'Segue em paralelo no prompt, sem bloquear a integração',
'Objetivo: aproveitar esse período pra refinar o prompt com mais casos de teste manuais no Ollama, preparando material pra Fase 3, que é quando os erros reais da integração vão aparecer.'),


(3, 'Fase 3', 'Semanas 7-10', 'Cada peça vira a versão boa', 'Todo mundo melhora a própria parte em cima de algo que já roda.', 'Roveris', 'Streaming de verdade, latência aceitável',
'Objetivo: sair do modelo "espera terminar tudo" pra um fluxo que responde em tempo real, pedaço por pedaço.

1. Pesquise sobre streaming no faster-whisper, ele suporta processar chunks de áudio incrementalmente em vez de esperar o arquivo inteiro.
2. Para o Piper, veja se dá pra começar a tocar a fala assim que os primeiros trechos de texto do LLM chegam, em vez de esperar a resposta completa.
3. Meça a latência em cada etapa (tempo de transcrição, tempo de resposta do LLM, tempo de síntese de voz) pra saber onde está o gargalo antes de otimizar às cegas.'),

(3, 'Fase 3', 'Semanas 7-10', 'Cada peça vira a versão boa', 'Todo mundo melhora a própria parte em cima de algo que já roda.', 'Arthur', 'WebSocket substitui requisição simples, chunks de áudio',
'Objetivo: trocar o modelo de requisição única por uma conexão persistente que troca dados em tempo real.

1. FastAPI tem suporte nativo a WebSocket, veja a documentação oficial sobre WebSockets.
2. Ao invés de mandar o arquivo inteiro de uma vez, o frontend manda pedaços (chunks) conforme grava, e o backend repassa pro pipeline conforme recebe.
3. Teste a conexão WebSocket isoladamente antes de plugar no fluxo de áudio real, é mais fácil debugar um problema de conexão separado de um problema de áudio.'),

(3, 'Fase 3', 'Semanas 7-10', 'Cada peça vira a versão boa', 'Todo mundo melhora a própria parte em cima de algo que já roda.', 'Chefe', 'Backend conectado ao banco, CRUD, busca por CPF, cadastro de cliente novo',
'Objetivo: sair de tabelas vazias pra um banco que o backend consegue ler e escrever de verdade.

1. Crie funções de acesso ao banco (repository ou service, dependendo do padrão que preferirem): buscar_cliente_por_cpf, criar_cliente, criar_pedido.
2. Exponha isso como rotas no FastAPI da Arthur, tipo GET /clientes/{cpf} e POST /clientes.
3. Lembre do RNF06 do roadmap, o CPF não deve ficar salvo em texto puro exposto, veja como fazer um hash ou criptografia simples de coluna no Postgres.
4. Teste as rotas com Postman antes de esperar a integração com o resto do sistema.'),

(3, 'Fase 3', 'Semanas 7-10', 'Cada peça vira a versão boa', 'Todo mundo melhora a própria parte em cima de algo que já roda.', 'Anderson', 'Interface de chamada real: botão ligar, timer, indicador de fala',
'Objetivo: sair do protótipo cru da Fase 1 pra algo que pareça de verdade uma tela de chamada.

1. Pense na tela como estados: chamando, em andamento, encerrada. Cada estado muda o que aparece na tela.
2. Um timer simples é só um setInterval contando segundos desde que a chamada começou.
3. Pro indicador de fala, uma opção simples é usar a Web Audio API pra pegar o volume do microfone em tempo real e animar algo na tela proporcional a esse volume.'),

(3, 'Fase 3', 'Semanas 7-10', 'Cada peça vira a versão boa', 'Todo mundo melhora a própria parte em cima de algo que já roda.', 'Nonato', 'Prompt tratando erros reais vistos nos testes da Fase 2',
'Objetivo: corrigir os problemas de comportamento do modelo que apareceram quando pessoas de verdade testaram na Fase 2.

1. Reveja as anotações de erro da Fase 1 e 2, tipo o modelo inventando produto ou perdendo o contexto.
2. Ajuste o system prompt adicionando exemplos concretos do que fazer nesses casos (few-shot prompting), isso costuma funcionar melhor que só pedir "não invente produtos".
3. Teste de novo no chat do Ollama antes de considerar resolvido, sempre validando os mesmos casos de erro que apareceram antes.'),


(4, 'Fase 4', 'Semanas 11-12', 'Lógica de negócio completa', 'Histórico do cliente, pedido estruturado e fluxo de ponta a ponta.', 'Chefe', 'Histórico do cliente alimentando a recomendação do LLM',
'Objetivo: fazer o backend saber o que o cliente já pediu antes, pra passar isso pro modelo usar na conversa.

1. Escreva uma query que retorna os últimos pedidos de um cliente e o item mais pedido por ele.
2. Exponha isso como uma rota tipo GET /clientes/{cpf}/historico.
3. Combine com a Nonato o formato exato desse retorno, já que é ela que vai usar isso no prompt.'),

(4, 'Fase 4', 'Semanas 11-12', 'Lógica de negócio completa', 'Histórico do cliente, pedido estruturado e fluxo de ponta a ponta.', 'Nonato', 'Histórico do cliente alimentando a recomendação do LLM',
'Objetivo: fazer o modelo usar o histórico do cliente (vindo da Chefe) pra sugerir produtos de forma natural na conversa.

1. Combine com a Chefe o formato de dado que ela vai te entregar.
2. Inclua esse histórico no system prompt ou como contexto adicional antes de cada resposta, dependendo de como o Roveris estruturou a chamada ao LLM.
3. Teste conversas onde o cliente está em dúvida, veja se o modelo recomenda o item certo com base no histórico, e não algo aleatório.'),

(4, 'Fase 4', 'Semanas 11-12', 'Lógica de negócio completa', 'Histórico do cliente, pedido estruturado e fluxo de ponta a ponta.', 'Roveris', 'Pedido estruturado saindo da conversa em formato que o backend consegue salvar',
'Objetivo: transformar a conversa livre em texto em um dado estruturado (itens, quantidade, endereço, pagamento) que o banco entende.

1. Uma abordagem comum é pedir pro próprio LLM responder em JSON no final da conversa, com uma instrução clara de formato no prompt.
2. Valide esse JSON antes de repassar pro backend, modelos às vezes retornam formato levemente errado, então trate esse caso.
3. Combine com a Arthur o formato exato desse JSON antes de implementar, pra ela já saber o que esperar receber.'),

(4, 'Fase 4', 'Semanas 11-12', 'Lógica de negócio completa', 'Histórico do cliente, pedido estruturado e fluxo de ponta a ponta.', 'Arthur', 'Fluxo completo orquestrado, chamada termina e grava o pedido',
'Objetivo: fechar o ciclo, do fim da chamada até o pedido salvo no banco.

1. Quando a chamada terminar, receba o JSON estruturado do Roveris e chame as funções de banco da Chefe pra criar o pedido e os itens.
2. Pense em como tratar erro, o que acontece se o JSON vier incompleto ou o cliente desistir no meio.
3. Teste o fluxo completo de ponta a ponta pelo menos uma vez por dia nessa fase, é fácil uma mudança de uma pessoa quebrar a integração sem perceber.'),

(4, 'Fase 4', 'Semanas 11-12', 'Lógica de negócio completa', 'Histórico do cliente, pedido estruturado e fluxo de ponta a ponta.', 'Anderson', 'Tela de resumo do pedido ao final',
'Objetivo: mostrar pro cliente o que foi pedido, antes de encerrar a chamada.

1. Depois que o backend confirma que salvou o pedido, o frontend recebe esse dado estruturado e monta uma tela simples de resumo, itens, quantidade, valor total.
2. Pense em como tratar o caso de erro, se o pedido não foi salvo por algum motivo, o cliente precisa saber disso claramente.');