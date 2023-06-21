import 'package:flutter/material.dart';
import 'package:wecheck/design-system/tokens.dart';

class Explainers extends StatelessWidget {
  const Explainers({Key? key}) : super(key: key);

  Widget _buildExplainerItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: DesignSystem.WecheckBrown,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 40,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: TextStyle(color: Color(0xFFF4F4F4)),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 15, 15, 15)),
      padding: EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 50,
      ),
      child: Row(
        children: [
          _buildExplainerItem(
            title: "Quick Process",
            subtitle:
                "Our process is short, quick and we have a turnaround time of less than 2 weeks for a response",
            icon: Icons.info_rounded,
          ),
          _buildExplainerItem(
            title: "Quick Process",
            subtitle:
                "Our process is short, quick and we have a turnaround time of less than 2 weeks for a response",
            icon: Icons.info_rounded,
          ),
          _buildExplainerItem(
            title: "Quick Process",
            subtitle:
                "Our process is short, quick and we have a turnaround time of less than 2 weeks for a response",
            icon: Icons.info_rounded,
          ),
          _buildExplainerItem(
            title: "Quick Process",
            subtitle:
                "Our process is short, quick and we have a turnaround time of less than 2 weeks for a response",
            icon: Icons.info_rounded,
          ),
        ],
      ),
    );
  }
}

class ExplainersMobile extends StatelessWidget {
  const ExplainersMobile({Key? key}) : super(key: key);

  Widget _buildExplainerItem(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
          icon,
          size: 40,
          color: Color(0xFF717171),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(color: Color(0xFF717171)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(children: [
        _buildExplainerItem(
            title: "Synchronise Documents",
            subtitle:
                "Upload listings to document portals and get maximum exposure for a property",
            icon: Icons.folder_copy_outlined),
        _buildExplainerItem(
            title: "Manage Inspections",
            subtitle:
                "Create inspections, list issues and document issues with photos and actions to be completed",
            icon: Icons.edit_off_outlined),
        _buildExplainerItem(
            title: "Marketing Material",
            subtitle:
                "Generate listing detail documents which can be sent to prospective buyers... ",
            icon: Icons.article_outlined),
        _buildExplainerItem(
            title: "Document Management",
            subtitle:
                "Various documents related to the sales and rental processes of properties...",
            icon: Icons.menu_book_outlined),
      ]),
    );
  }
}
