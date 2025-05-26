import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/patient_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart'; 
import 'package:clypsera/app/constants/uidata.dart'; 

class PatientListItem extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onTap;

  const PatientListItem({
    super.key,
    required this.patient,
    this.onTap,
  });

  Map<String, dynamic> _getGenderIconData(Gender gender) {
    String iconUrl;
    Color iconTintColor;

    switch (gender) {
      case Gender.female:
        iconUrl = genderFemaleIcon; 
        iconTintColor = Color(0xffA3BDCD); 
      case Gender.male:
        iconUrl = genderMaleIcon; 
        iconTintColor = Style.primaryColor; 
        break;
      default:
        return {
          'iconData': Icons.person_rounded,
          'color': Colors.grey.shade600
        };
    }
    return {'url': iconUrl, 'color': iconTintColor};
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = Style.whiteColor;
    final Color avatarCircleBackgroundColor = Colors.grey.shade200;
    const double avatarCircleDiameter =
        52.0; 
    const double genderIconContainerDiameter =
        28.0; 
    const double genderIconSize =
        16.0;
    final genderData = _getGenderIconData(patient.gender);

    // Style teks
    final TextStyle patientNameStyle = Style.headLineStyle9;
    final TextStyle patientDetailStyle = Style.headLineStyle15;

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16), 
      ),
      color: cardBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: avatarCircleDiameter +
                    (genderIconContainerDiameter /
                        3),
                height: avatarCircleDiameter,
                child: Stack(
                  alignment: Alignment
                      .centerLeft, 
                  children: [
                    Container(
                      width: avatarCircleDiameter,
                      height: avatarCircleDiameter,
                      decoration: BoxDecoration(
                        color: avatarCircleBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: genderIconContainerDiameter,
                        height: genderIconContainerDiameter,
                        decoration: BoxDecoration(
                            color: genderData['color']
                                as Color, 
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: cardBackgroundColor,
                                width: 2.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 3,
                                offset: const Offset(1, 1),
                              )
                            ]),
                        child: Center(
                          child: genderData['iconData'] != null
                              ? Icon(genderData['iconData'] as IconData,
                                  color: Colors.white, size: genderIconSize)
                              : Image.network(
                                  genderData['url'] as String,
                                  width: genderIconSize,
                                  height: genderIconSize,
                                  color: Colors
                                      .white, 
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.person,
                                          size: genderIconSize,
                                          color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      patient.name,
                      style: patientNameStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient.cleftDescription,
                      style: patientDetailStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                patient.date,
                style: patientDetailStyle.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
