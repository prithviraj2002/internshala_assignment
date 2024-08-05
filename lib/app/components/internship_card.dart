import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../data/model/internship_data_model.dart';

class InternshipCard extends StatelessWidget {
  InternshipData internshipData;

  InternshipCard({required this.internshipData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                internshipData.title ?? "Internship Title",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                  width: 200,
                  child: Text(
                    internshipData.companyName ?? "Internship company name",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  )),
              const SizedBox(
                height: 12,
              ),
              internshipData.workFromHome != null ?
                  internshipData.workFromHome! ? const Row(
                    children: <Widget>[
                      Icon(Icons.home_outlined, color: Colors.black54,),
                      SizedBox(width: 4,),
                      Text("Work from Home", style: TextStyle(fontWeight: FontWeight.w300),),
                    ],
                  ) : Row(
                    children: <Widget>[
                      const Icon(Icons.location_on_outlined, color: Colors.black54),
                      const SizedBox(width: 4,),
                      Text(internshipData.locationNames != null ?
                      internshipData.locationNames!.isEmpty ? "" : internshipData.locationNames!.first! : "",
                        style: const TextStyle(fontWeight: FontWeight.w300),)
                    ],
                  ) : Container(),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.not_started_outlined, color: Colors.black54, size: 20,),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(internshipData.startDate ?? "Starts immediately", style: TextStyle(fontWeight: FontWeight.w300),),
                  const SizedBox(
                    width: 12,
                  ),
                  const Icon(Icons.date_range, color: Colors.black54, size: 20,),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(internshipData.duration ?? "", style: const TextStyle(fontWeight: FontWeight.w300),),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.money, color: Colors.black54, size:20),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(internshipData.stipend!.salary ?? "", style: const TextStyle(fontWeight: FontWeight.w300),),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Container(
                    height: 24,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(4)
                    ),
                      child: Center(child: Text(internshipData.labels!.first!.labelMobile!.first!))
                  )
                ],
              )
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: <Widget>[
              Image.asset(Assets.pngsInternshalaLogo, scale: 20,),
              const SizedBox(height: 170,),
            ],
          ),
        ],
      ),
    );
  }
}
