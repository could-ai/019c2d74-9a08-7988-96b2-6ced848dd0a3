import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ClickDollarApp());
}

class ClickDollarApp extends StatelessWidget {
  const ClickDollarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClickDollar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Default, but explicit is good
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE), // Primary Purple
          primary: const Color(0xFF6200EE),
          secondary: const Color(0xFF03DAC6),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedTimeRange = '1M';
  final List<String> _timeRanges = ['1D', '1W', '1M', '3M', '1Y', 'ALL'];

  // Mock Data for Campaigns
  final List<Campaign> _campaigns = [
    Campaign(
      name: 'Summer Sale Promo',
      revenue: 4520.50,
      uniqueVisitors: 1250,
      totalVisits: 3400,
      totalThreats: 12,
      totalClicks: 850,
      totalSales: 145,
    ),
    Campaign(
      name: 'Tech Gadgets Q3',
      revenue: 2890.00,
      uniqueVisitors: 980,
      totalVisits: 2100,
      totalThreats: 5,
      totalClicks: 620,
      totalSales: 89,
    ),
    Campaign(
      name: 'Crypto Affiliate Link',
      revenue: 1240.75,
      uniqueVisitors: 450,
      totalVisits: 890,
      totalThreats: 45,
      totalClicks: 210,
      totalSales: 34,
    ),
    Campaign(
      name: 'Health & Wellness',
      revenue: 5600.20,
      uniqueVisitors: 2100,
      totalVisits: 5600,
      totalThreats: 8,
      totalClicks: 1200,
      totalSales: 210,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.analytics_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'ClickDollar',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 28),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 32),
              _buildChartSection(),
              const SizedBox(height: 24),
              _buildTimeRangeSelector(),
              const SizedBox(height: 32),
              const Text(
                'Campaigns',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildCampaignList(),
              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Revenue',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currencyFormat.format(14251.45),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.trending_up, color: Colors.green, size: 18),
              const SizedBox(width: 4),
              Text(
                '+\$1,240.50 (9.5%)',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                ' vs last 7 days',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection() {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 6000,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 2000),
                FlSpot(1, 1800),
                FlSpot(2, 3500),
                FlSpot(3, 2800),
                FlSpot(4, 4200),
                FlSpot(5, 3900),
                FlSpot(6, 4800),
                FlSpot(7, 4100),
                FlSpot(8, 5200),
                FlSpot(9, 4900),
                FlSpot(10, 5800),
              ],
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => Colors.black87,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '\$${barSpot.y.toStringAsFixed(0)}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _timeRanges.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final range = _timeRanges[index];
          final isSelected = range == _selectedTimeRange;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeRange = range;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                range,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCampaignList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _campaigns.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CampaignCard(campaign: _campaigns[index]);
      },
    );
  }
}

class Campaign {
  final String name;
  final double revenue;
  final int uniqueVisitors;
  final int totalVisits;
  final int totalThreats;
  final int totalClicks;
  final int totalSales;

  Campaign({
    required this.name,
    required this.revenue,
    required this.uniqueVisitors,
    required this.totalVisits,
    required this.totalThreats,
    required this.totalClicks,
    required this.totalSales,
  });
}

class CampaignCard extends StatefulWidget {
  final Campaign campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  State<CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          // Header (Always visible)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(16),
              bottom: Radius.circular(_isExpanded ? 0 : 16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.campaign, color: Colors.purple),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.campaign.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Campaign metrics',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormat.format(widget.campaign.revenue),
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Expanded Content
          AnimatedCrossFade(
            firstChild: Container(height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetricItem(Icons.person_outline, 'Unique', widget.campaign.uniqueVisitors.toString())),
                      Expanded(child: _buildMetricItem(Icons.group_outlined, 'Visits', widget.campaign.totalVisits.toString())),
                      Expanded(child: _buildMetricItem(Icons.shield_outlined, 'Threats', widget.campaign.totalThreats.toString(), isWarning: true)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetricItem(Icons.touch_app_outlined, 'Clicks', widget.campaign.totalClicks.toString())),
                      Expanded(child: _buildMetricItem(Icons.attach_money, 'Sales', widget.campaign.totalSales.toString(), isSuccess: true)),
                      const Spacer(), // Fill the grid
                    ],
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(IconData icon, String label, String value, {bool isWarning = false, bool isSuccess = false}) {
    Color iconColor = Colors.grey[600]!;
    Color bgColor = Colors.grey[100]!;
    
    if (isWarning) {
      iconColor = Colors.orange[700]!;
      bgColor = Colors.orange.withOpacity(0.1);
    } else if (isSuccess) {
      iconColor = Colors.green[700]!;
      bgColor = Colors.green.withOpacity(0.1);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
