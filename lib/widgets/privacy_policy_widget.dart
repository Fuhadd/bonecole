import 'package:bonecole/widgets/plain_text_widget.dart';
import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';
import 'article_title_widget.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              verticalSpacer(20),
              const Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackColor,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationThickness: 7,
                ),
              ),
              verticalSpacer(20),
              const Text(
                "by Bonecole INC SARLU",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackColor,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationThickness: 7,
                ),
              ),
              verticalSpacer(15),

              // verticalSpacer(20),
              const ArticleTitle(
                title: "I / The objective of the confidentiality policy",
              ),
              const PlainTextWidget(
                title:
                    "This privacy policy is established with the aim of informing users of the site https://www.bonecole.com/, owned and managed by BONECOLE INC SARLU, of the following terms:",
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: PlainTextWidget(
                  title:
                      "● Personal data collected by the website\n● The use of this data\n● Access to this data\n● The rights that users of the site have\n● The policy related to the use of cookies",
                ),
              ),
              const PlainTextWidget(
                title:
                    "This confidentiality policy operates in parallel with the general conditions of the Bonecole site.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "II / Applicable laws",
              ),
              const PlainRowTextWidget(
                title:
                    "In accordance with the General Data Protection Regulations, this privacy policy is subject to the following regulations: Personal data is:",
              ),

              const PlainRowTextWidget(
                title: "processed lawfully and transparently;",
              ),
              const PlainRowTextWidget(
                title:
                    "collected for specific, explicit and legitimate purposes, and will not be further processed in a manner incompatible with these purposes. In accordance with Law No L/2016/037/AN, relating to cyber security and the protection of personal data in the Republic of Guinea;",
              ),

              const PlainRowTextWidget(
                title:
                    "adequate, relevant and limited to what is necessary in the context of the purposes for which they are processed;",
              ),
              const PlainRowTextWidget(
                title:
                    "accurate, and if necessary kept up to date. All reasonable measures will be taken to correct incorrect data in relation to the purpose for which it is collected;",
              ),

              const PlainRowTextWidget(
                title:
                    "kept in a form allowing the identification of the persons concerned for a sufficient period of time for their processing;",
              ),

              const PlainRowTextWidget(
                title:
                    "kept in a form allowing the identification of the persons concerned for a sufficient period of time for their processing;",
              ),

              const PlainRowTextWidget(
                title:
                    "processed in a way that ensures its security, including with regard to unauthorized or unlawful processing, loss or destruction of such data, whether accidental or intentional. \nThe processing of the collected data is only lawful if at least one of the following conditions is met:",
              ),
              const PlainRowTextWidget(
                title:
                    "The person concerned by the data has consented to the processing of the data for one or more specific purposes.",
              ),
              const PlainRowTextWidget(
                title:
                    "The processing of data is necessary for the performance of a contract to which the data subject is a party or for the execution of pre-contractual measures taken at the request of the data subject.",
              ),
              const PlainRowTextWidget(
                title:
                    "The processing is necessary for the fulfillment of a legal obligation to which the controller, Bonecole INC SARLU, is subject.",
              ),

              const PlainRowTextWidget(
                title:
                    "The processing is necessary to carry out a mission of public interest entrusted to Bonecole INC SARLU.",
              ),

              const PlainRowTextWidget(
                title:
                    "kept in a form allowing the identification of the persons concerned for a sufficient period of time for their processing;",
              ),

              const PlainRowTextWidget(
                title:
                    "Processing is necessary for the purposes of the legitimate interests pursued by the controller or a third party, unless overridden by the interests, fundamental freedoms or rights of the data subject.",
              ),

              verticalSpacer(20),
              const ArticleTitle(
                title: "III / Consent",
              ),
              const PlainRowTextWidget(
                title: "All terms included in this Privacy Policy;",
              ),

              const PlainRowTextWidget(
                title:
                    "The collection, use and retention of data listed in this privacy policy.",
              ),

              verticalSpacer(20),
              const ArticleTitle(
                title: "IV / Personal data collected",
              ),
              const PlainTextWidget(
                title:
                    "When browsing the Bonecole site or application, various personal data about users are collected.\nThe following data is collected automatically:\nEmail address and/or Facebook account, and telephone number",
              ),
              const PlainTextWidget(
                title:
                    "The following data is collected non-automatically:\nFirst and last name, telephone number, school of origin, This data is collected after completion of the user profile in the my profile section. No additional data is collected without first informing you.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "V / Processing of this data",
              ),
              const PlainTextWidget(
                title:
                    "Personal data collected on the Bonecole website is only collected and processed for the purposes specified in this privacy policy and/or in the relevant pages of the site. The personal data we collect will not be used for any other purpose other than analysis for the simple purpose of improving the quality of services provided to users.",
              ),
              verticalSpacer(15),
              verticalSpacer(20),
              const ArticleTitle(
                title: "VI / Sharing of personal data collected",
              ),

              const PlainRowTextWidget(
                title:
                    "Employees: We may openly disclose information to Bonecole Company employees to the extent that they need it to pursue the purposes set out in this policy;",
              ),
              const PlainRowTextWidget(
                title:
                    "Use of our site may require the transfer of specific data (email, username and telephone number) to our API providers (Google, Facebook and Orange Finances Mobile Guinée)",
              ),

              const PlainTextWidget(
                title:
                    "Furthermore, the personal data collected may be shared:",
              ),

              const PlainRowTextWidget(
                title: "If the Bonecole company is obliged to do so by law",
              ),
              const PlainRowTextWidget(
                title:
                    "If the information is required for any legal proceedings",
              ),
              const PlainRowTextWidget(
                title:
                    "In order to protect the legal rights of the Bonecole company",
              ),

              const PlainTextWidget(
                title:
                    "Apart from the situations provided for in this policy, personal information will under no circumstances be disclosed or shared to third parties.",
              ),

              verticalSpacer(20),
              const ArticleTitle(
                title: "VII / Storage and protection of personal data",
              ),

              const PlainTextWidget(
                title:
                    "The Bonecole company does not retain personal data for longer than is necessary to achieve the purposes for which they are collected. In order to protect this data, we implement the following measures:",
              ),

              const PlainTextWidget(
                title:
                    "Deployment of a high security system on all our products (site and application) to protect company and user data, and the commitment of non-disclosure user data to third parties.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "VIII / User rights",
              ),
              const PlainTextWidget(
                title:
                    "In accordance with current law, users of the Bonecole site have, with regard to their personal data, the following rights:",
              ),
              const PlainRowTextWidget(
                title: "Permission to access",
              ),
              const PlainRowTextWidget(
                title: "Right of rectification",
                paddingTop: 2,
              ),
              const PlainRowTextWidget(
                title: "Right to erasure",
                paddingTop: 2,
              ),
              const PlainRowTextWidget(
                title: "Right to restrict processing",
                paddingTop: 2,
              ),
              const PlainRowTextWidget(
                title: "Right to data portability",
                paddingTop: 2,
              ),
              const PlainRowTextWidget(
                title: "Right to object",
                paddingTop: 2,
              ),
              verticalSpacer(20),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: CustomColors.blackColor,
                    fontSize: 12,
                    height: 1.7,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "To assert one of your rights, access your data, modify or delete it in any way, you can communicate with our customer service via email: ",
                    ),
                    TextSpan(
                      text: "contact@bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "IX / Cookie policy",
              ),

              const PlainTextWidget(
                title:
                    "A cookie is a file stored on a user's hard drive when they browse a website. This cookie allows us to better understand the data relating to the user's browsing habits in order to offer them a better user experience.",
              ),

              const PlainTextWidget(
                title:
                    "The Bonecole site uses the following cookies:\nBonecole uses technical cookies to enable the site to function properly.",
              ),

              const PlainTextWidget(
                title:
                    "The Bonecole site also uses the following third-party cookies:\nFacebook, Google services, Orange.",
              ),

              verticalSpacer(20),
              const ArticleTitle(
                title: "X / Modification of the privacy policy",
              ),

              const PlainTextWidget(
                title:
                    "In order to remain in compliance with the law or to reflect any changes in our process for managing personal data, this privacy policy may change and be modified regularly. Users are recommended to check this policy regularly in order to stay informed of our policy in terms of collection and processing of personal data.",
              ),

              verticalSpacer(20),
              const ArticleTitle(
                title: "XI / Contact",
              ),

              verticalSpacer(15),

              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: CustomColors.blackColor,
                      fontSize: 12,
                      height: 1.7,
                    ),
                    children: [
                      TextSpan(
                        text: "Contact us at +224 611 23 88 88 or at\n",
                      ),
                      TextSpan(
                        text: "contact@bonecole.com",
                        style: TextStyle(
                          // fontSize: 25.sp,
                          // fontWeight: FontWeight.w700,
                          color: CustomColors.blueColor,
                          decorationColor: CustomColors.blueColor,
                          decorationThickness: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpacer(40),
            ],
          ),
        ),
      ),
    );
  }
}
