import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

// ---------- Paleta ----------
const _bg = Color(0xFF0B0F14);
const _surface = Color(0xFF141A21);
const _border = Color(0xFF232B35);
const _primary = Color(0xFF00C2A8);
const _accent = Color(0xFF7C5CFF);
const _muted = Color(0xFF9AA6B2);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio — Dashboard E-commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _bg,
        colorScheme: const ColorScheme.dark(
          primary: _primary,
          secondary: _accent,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const CasePage(),
    );
  }
}

class CasePage extends StatefulWidget {
  const CasePage({super.key});
  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  final _projetosKey = GlobalKey();
  final _sobreKey = GlobalKey();
  final _contatoKey = GlobalKey();

  void _go(GlobalKey k) {
    final ctx = k.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 860;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _bg.withOpacity(0.85),
        elevation: 0,
        title: const Text('[ LOGO / NOME ]',
            style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1)),
        actions: wide
            ? [
                TextButton(onPressed: () => _go(_projetosKey), child: const Text('Projetos')),
                TextButton(onPressed: () => _go(_sobreKey), child: const Text('Sobre')),
                TextButton(onPressed: () => _go(_contatoKey), child: const Text('Contato')),
                const SizedBox(width: 16),
              ]
            : null,
      ),
      drawer: wide
          ? null
          : Drawer(
              child: ListView(children: [
                const DrawerHeader(child: Center(child: Text('[ LOGO / NOME ]'))),
                ListTile(title: const Text('Projetos'), onTap: () { Navigator.pop(context); _go(_projetosKey); }),
                ListTile(title: const Text('Sobre'), onTap: () { Navigator.pop(context); _go(_sobreKey); }),
                ListTile(title: const Text('Contato'), onTap: () { Navigator.pop(context); _go(_contatoKey); }),
              ]),
            ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 20, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCard(wide: wide),
                  const SizedBox(height: 28),
                  const _MockupArea(),
                  const SizedBox(height: 28),
                  const _ProblemSolution(),
                  const SizedBox(height: 28),
                  const _Stack(),
                  const SizedBox(height: 28),
                  _Features(wide: wide),
                  const SizedBox(height: 28),
                  const _Results(),
                  const SizedBox(height: 28),
                  const _CTA(key: ValueKey('cta')),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text('© 2026 — Feito com Flutter',
                        style: TextStyle(color: _muted, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Seção 1: Card de destaque ----------
class _HeroCard extends StatelessWidget {
  final bool wide;
  const _HeroCard({required this.wide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_surface, _surface.withOpacity(0.6)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(spacing: 8, runSpacing: 8, children: const [
            _Tag(label: 'Front-end'),
            _Tag(label: 'React'),
            _Tag(label: 'Out 2026', icon: Icons.calendar_today_outlined),
          ]),
          const SizedBox(height: 20),
          Text(
            '🎯 Desenvolvimento de um Dashboard E-commerce em Tempo Real',
            style: TextStyle(
                fontSize: wide ? 28 : 22,
                fontWeight: FontWeight.w800,
                height: 1.25),
          ),
          const SizedBox(height: 14),
          const Text(
            'Uma aplicação web escalável com atualizações ao vivo, gráficos interativos '
            'e foco total na experiência do usuário (UX).',
            style: TextStyle(color: _muted, fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 24),
          Wrap(spacing: 12, runSpacing: 12, children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onPressed: () => _open('https://github.com/dzzeti-source/Flutter'),
              icon: const Icon(Icons.code, size: 18),
              label: const Text('Ver Código no GitHub'),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _accent),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onPressed: () => _open('https://dzzeti-source.github.io/Flutter/'),
              icon: const Icon(Icons.rocket_launch_outlined, size: 18),
              label: const Text('Acessar Deploy em Produção'),
            ),
          ]),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final IconData? icon;
  const _Tag({required this.label, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _primary.withOpacity(0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: _primary),
          const SizedBox(width: 6),
        ],
        Text(label,
            style: const TextStyle(
                color: _primary, fontSize: 12, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ---------- Seção 2: Mockup ----------
class _MockupArea extends StatelessWidget {
  const _MockupArea();
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image_outlined, size: 56, color: _muted),
              SizedBox(height: 12),
              Text(
                '[ Imagem/GIF ou Vídeo demonstrativo da interface da aplicação ]',
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Seção 3: Problema & Solução ----------
class _ProblemSolution extends StatelessWidget {
  const _ProblemSolution();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _BlockCard(
          icon: Icons.warning_amber_rounded,
          title: 'O Desafio',
          body:
              'Lojistas precisavam monitorar vendas sem atualizar a página manualmente, '
              'perdendo tempo e dados críticos para decisões rápidas.',
        ),
        SizedBox(height: 16),
        _BlockCard(
          icon: Icons.lightbulb_outline,
          title: 'A Solução',
          body:
              'Criação de um pipeline de dados com WebSockets e renderização otimizada, '
              'entregando atualizações em tempo real sem recarregar a tela.',
          accent: true,
        ),
      ],
    );
  }
}

class _BlockCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool accent;
  const _BlockCard({required this.icon, required this.title, required this.body, this.accent = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent ? _primary.withOpacity(0.5) : _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent ? _primary : _accent, size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(body, style: const TextStyle(color: _muted, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Seção 4: Stack ----------
class _Stack extends StatelessWidget {
  const _Stack();
  @override
  Widget build(BuildContext context) {
    final items = [
      ('React.js', 'Componentização e ecossistema maduro.'),
      ('Node.js', 'WebSockets leves e alta concorrência.'),
      ('Tailwind CSS', 'UI consistente e responsiva com velocidade.'),
    ];
    return _Section(
      title: '🛠️ Arquitetura e Tecnologias',
      child: Column(
        children: items
            .map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(e.$1,
                            style: const TextStyle(
                                color: _accent, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Text(e.$2, style: const TextStyle(color: _muted))),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// ---------- Seção 5: Features ----------
class _Features extends StatelessWidget {
  final bool wide;
  const _Features({required this.wide});
  @override
  Widget build(BuildContext context) {
    final cards = [
      ('🎨 UI/UX Responsivo', 'Se adapta a qualquer tamanho de tela.'),
      ('📊 Gráficos Dinâmicos', 'Atualização a cada 500ms usando ApexCharts.'),
      ('🔒 Autenticação', 'Proteção de rotas com JWT.'),
    ];
    return _Section(
      title: '⚡ Características Principais',
      child: wide
          ? Row(
              children: cards
                  .map((c) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _FeatureCard(title: c.$1, body: c.$2),
                        ),
                      ))
                  .toList(),
            )
          : Column(
              children: cards
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _FeatureCard(title: c.$1, body: c.$2),
                      ))
                  .toList(),
            ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String body;
  const _FeatureCard({required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(color: _muted, height: 1.5, fontSize: 13)),
        ],
      ),
    );
  }
}

// ---------- Seção 6: Resultados ----------
class _Results extends StatelessWidget {
  const _Results();
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '📈 Resultados e Lições Aprendidas',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _Bullet(text: 'Desempenho: redução de 40% no tempo de carregamento inicial (LCP).'),
          SizedBox(height: 10),
          _Bullet(text: 'Aprendizado: implementação profunda de gerenciamento de estado global.'),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(top: 6, right: 10),
        child: Icon(Icons.circle, size: 8, color: _primary),
      ),
      Expanded(child: Text(text, style: const TextStyle(color: _muted, height: 1.6))),
    ]);
  }
}

// ---------- Seção 7: CTA ----------
class _CTA extends StatelessWidget {
  const _CTA({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(colors: [
          _primary.withOpacity(0.18),
          _accent.withOpacity(0.18),
        ]),
        border: Border.all(color: _primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🤝 Vamos trabalhar juntos?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text(
            'Gostou do projeto? Estou disponível para novos desafios e contratos.',
            style: TextStyle(color: _muted, height: 1.6),
          ),
          const SizedBox(height: 20),
          Wrap(spacing: 12, runSpacing: 12, children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              onPressed: () => _open('mailto:seu@email.com'),
              icon: const Icon(Icons.email_outlined, size: 18),
              label: const Text('Enviar Mensagem por E-mail'),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _accent),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              onPressed: () => _open('https://linkedin.com/in/seu-usuario'),
              icon: const Icon(Icons.work_outline, size: 18),
              label: const Text('Conectar no LinkedIn'),
            ),
          ]),
        ],
      ),
    );
  }
}

// ---------- Helper: Section wrapper ----------
class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

Future<void> _open(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) launchUrl(uri, webOnlyWindowName: '_blank');
}
