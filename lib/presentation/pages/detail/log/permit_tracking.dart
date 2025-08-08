import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/logs/get_logs_permit_bloc.dart';
import 'package:tracking_apps/presentation/component/card_log_permit.dart';

class PermitTrackingPage extends StatefulWidget {
  final String permitDescription;
  final String permitNumber;
  final String permitId;

  const PermitTrackingPage({
    super.key,
    required this.permitId,
    required this.permitDescription,
    required this.permitNumber,
  });

  @override
  State<PermitTrackingPage> createState() => _PermitTrackingPageState();
}

class _PermitTrackingPageState extends State<PermitTrackingPage> {
  String? _authToken;

  final List<String> allStages = [
    'Upload',
    'Saran Polres',
    'Rekom. Polda',
    'Verifikasi 1',
    'Submit',
    'Draft',
    'Penelitian Dokumen',
    'Verifikasi 2',
    'Verifikasi 3',
    'Approval',
    'Penomoran',
    'Release'
  ];

  @override
  void initState() {
    super.initState();
    _loadAuthTokenAndFetch();
  }

  Future<void> _loadAuthTokenAndFetch() async {
    final token = await SharedPreferencesService.instance
        .getData<String>(PreferenceKey.authToken);
    setState(() => _authToken = token);
    if (token != null) _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    context
        .read<PermitLetterLogBloc>()
        .add(GetPermitLettersLogEvent(id: widget.permitId));
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day.toString().padLeft(2, '0')} ${_month(dt.month)} ${dt.year}\n'
          '${dt.hour.toString().padLeft(2, '0')}:'
          '${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  String _month(int m) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return names[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rincian Progress',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Satoshi',
            color: Colors.white,
          ),
        ),
        flexibleSpace:
            Container(decoration: BoxDecoration(gradient: headerAppBar)),
        centerTitle: true,
        elevation: 0,
      ),
      // 4. Pull-to-refresh wrapping everything
      body: RefreshIndicator(
        onRefresh: _fetchLogs,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CardLogPermit(permitDescription:widget.permitDescription, permitNumber:widget.permitNumber),
              SizedBox(height: 12.h),
              Expanded(
                child: BlocBuilder<PermitLetterLogBloc, PermitLetterLogState>(
                  builder: (context, state) {
                    if (_authToken == null) {
                      return const Center(
                          child: Text('User not authenticated'));
                    }
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is PermitLetterLogLoadedState) {
                      final logs = state.listPermitLog;
                      // build a set of completed stage names:
                      final done = logs.map((l) => l.statusTahapan).toSet();
                      return SingleChildScrollView(
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineThemeData(
                            nodePosition: 0.3,
                            indicatorTheme: IndicatorThemeData(size: 18.0),
                          ),
                          builder: TimelineTileBuilder.connectedFromStyle(
                            contentsAlign: ContentsAlign.basic,
                            itemCount: allStages.length,
                            oppositeContentsBuilder: (ctx, idx) {
                              final stage = allStages[idx];
                              if (!done.contains(stage)) {
                                return const SizedBox.shrink(); // 2.
                              }
                              // find the log entry for this stage
                              final log = logs
                                  .firstWhere((l) => l.statusTahapan == stage);
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 8.w, bottom: 16.h),
                                child: Text(
                                  _formatDate(log.updatedAt),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              );
                            },
                            contentsBuilder: (ctx, idx) {
                              final stage = allStages[idx];
                              final isDone = done.contains(stage);
                              // description: if done, from log; else generic
                              final desc = isDone
                                  ? logs
                                      .firstWhere(
                                          (l) => l.statusTahapan == stage)
                                      .description
                                  : 'Menunggu tahap sebelumnya';
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 8.w, bottom: 16.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stage,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            isDone ? Colors.black : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      desc,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDone
                                            ? Colors.black87
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            indicatorStyleBuilder: (ctx, idx) {
                              final isDone = done.contains(allStages[idx]);
                              return isDone
                                  ? IndicatorStyle.dot
                                  : IndicatorStyle.outlined;
                            },
                            connectorStyleBuilder: (context, index) {
                              final isDone = done.contains(allStages[index]);
                              return isDone
                                  ? ConnectorStyle.solidLine
                                  : ConnectorStyle.dashedLine;
                            },
                          ),
                        ),
                      );
                    }
                    if (state is PermitLetterLogFailedState) {
                      return Center(
                        child: Text(state.message ?? 'Failed to load logs'),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
