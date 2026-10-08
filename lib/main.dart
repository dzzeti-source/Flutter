import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A).withOpacity(0.9),
        elevation: 0,
        title: const Text('Meu Portfólio',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: isWide
            ? [
                _navBtn('Sobre', () => _scrollTo(_aboutKey)),
                _navBtn('Habilidades', () => _scrollTo(_skillsKey)),
                _navBtn('Projetos', () => _scrollTo(_projectsKey)),
                _navBtn('Contato', () => _scrollTo(_contactKey)),
                const SizedBox(width: 16),
              ]
            : null,
      ),
      drawer: !isWide
          ? Drawer(
              child: ListView(children: [
                const DrawerHeader(
                    child: Center(
                        child: Text('Menu',
                            style: TextStyle(fontSize: 24, color: Colors.white)))),
                ListTile(title: const Text('Sobre'), onTap: () { Navigator.pop(context); _scrollTo(_aboutKey); }),
                ListTile(title: const Text('Habilidades'), onTap: () { Navigator.pop(context); _scrollTo(_skillsKey); }),
                ListTile(title: const Text('Projetos'), onTap: () { Navigator.pop(context); _scrollTo(_projectsKey); }),
                ListTile(title: const Text('Contato'), onTap: () { Navigator.pop(context); _scrollTo(_contactKey); }),
              ]),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          _heroSection(isWide),
          _aboutSection(_aboutKey, isWide),
          _skillsSection(_skillsKey, isWide),
          _projectsSection(_projectsKey, isWide),
          _contactSection(_contactKey),
          _footer(),
        ]),
      ),
    );
  }

  Widget _navBtn(String label, VoidCallback onTap) => TextButton(
        onPressed: onTap,
        child: Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 16)),
      );

  // ---------- HERO ----------
  Widget _heroSection(bool isWide) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 80),
      child: Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                const Text('Olá, eu sou 👋',
                    style: TextStyle(color: Colors.white70, fontSize: 20)),
                const SizedBox(height: 12),
                const Text('Seu Nome Aqui',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF00D9FF)],
                  ).createShader(bounds),
                  child: const Text('Desenvolvedor Flutter',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Text(
                    'Apaixonado por criar aplicativos mobile e web com Flutter.',
                    style: TextStyle(color: Colors.white60, fontSize: 16)),
                const SizedBox(height: 32),
                Row(children: [
                  ElevatedButton.icon(
                    onPressed: () => _scrollTo(_contactKey),
                    icon: const Icon(Icons.email),
                    label: const Text('Entre em contato'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Container(
            width: isWide ? 260 : 180,
            height: isWide ? 260 : 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF00D9FF)]),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 8),
              ],
            ),
            child: const Icon(Icons.person, size: 120, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ---------- SOBRE ----------
  Widget _aboutSection(GlobalKey key, bool isWide) {
    return _sectionWrapper(
      key,
      title: 'Sobre Mim',
      child: const Text(
        'Sou desenvolvedor(a) com experiência em Flutter, Dart e desenvolvimento web. '
        'Adoro transformar ideias em produtos digitais bonitos e funcionais. '
        'Tenho experiência com APIs REST, Firebase, Git/GitHub e metodologias ágeis.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.8),
      ),
    );
  }

  // ---------- HABILIDADES ----------
  Widget _skillsSection(GlobalKey key, bool isWide) {
    final skills = [
      {'name': 'Flutter / Dart', 'value': 0.9},
      {'name': 'Firebase', 'value': 0.8},
      {'name': 'APIs REST', 'value': 0.85},
      {'name': 'UI/UX Design', 'value': 0.75},
      {'name': 'Git / GitHub', 'value': 0.9},
    ];
    return _sectionWrapper(
      key,
      title: 'Habilidades',
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: skills.map((s) {
          return SizedBox(
            width: isWide ? 400 : 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'] as String,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: s['value'] as double,
                    minHeight: 10,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF00D9FF)),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------- PROJETOS ----------
  Widget _projectsSection(GlobalKey key, bool isWide) {
    final projects = [
      {'title': 'App de Tarefas', 'desc': 'App Flutter com Firebase.', 'icon': Icons.check_circle},
      {'title': 'E-commerce', 'desc': 'Loja virtual em Flutter Web.', 'icon': Icons.shopping_cart},
      {'title': 'Dashboard', 'desc': 'Dashboard analítico responsivo.', 'icon': Icons.bar_chart},
      {'title': 'Chat App', 'desc': 'Chat em tempo real com Firestore.', 'icon': Icons.chat},
    ];
    return _sectionWrapper(
      key,
      title: 'Projetos',
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: projects.map((p) {
          return Container(
            width: isWide ? 300 : 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(p['icon'] as IconData, size: 40, color: const Color(0xFF00D9FF)),
                const SizedBox(height: 16),
                Text(p['title'] as String,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(p['desc'] as String,
                    style: const TextStyle(color: Colors.white60)),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://github.com')),
                  child: const Text('Ver mais →',
                      style: TextStyle(color: Color(0xFF6C63FF))),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------- CONTATO ----------
  Widget _contactSection(GlobalKey key) {
    return _sectionWrapper(
      key,
      title: 'Contato',
      child: Column(
        children: [
          const Text('Vamos trabalhar juntos!',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _contactIcon(FontAwesomeIcons.github, 'GitHub',
                  'https://github.com/seu-usuario'),
              _contactIcon(FontAwesomeIcons.linkedin, 'LinkedIn',
                  'https://linkedin.com/in/seu-usuario'),
              _contactIcon(FontAwesomeIcons.envelope, 'Email',
                  'mailto:seuemail@exemplo.com'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactIcon(IconData icon, String label, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFF1A1A2E)),
          child: Icon(icon, color: const Color(0xFF00D9FF), size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ]),
    );
  }

  Widget _footer() => Container(
        padding: const EdgeInsets.all(24),
        child: const Text('© 2026 Seu Nome. Feito com Flutter 💙',
            style: TextStyle(color: Colors.white38)),
      );

  Widget _sectionWrapper(GlobalKey key,
      {required String title, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
            width: 60, height: 4, color: const Color(0xFF6C63FF)),
        const SizedBox(height: 40),
        child,
      ]),
    );
  }
}
