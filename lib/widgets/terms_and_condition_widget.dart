import 'package:bonecole/widgets/plain_text_widget.dart';
import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';
import 'article_title_widget.dart';

class TermsAndConditionWidget extends StatelessWidget {
  const TermsAndConditionWidget({
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
                "Conditions générales d'utilisation",
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
                "En vigueur le 17/01/2022",
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
              const PlainTextWidget(
                title:
                    "Conditions générales d'utilisationEn vigueur le 17/01/2022Les présentes conditions générales d'utilisation (dites « CGU ») ont pour objet l'encadrement juridique des modalités de mise à disposition du site et des services par BONECOLE INC et de définir les conditions d’accès et d’utilisation des services par « l'Utilisateur ».Les présentes CGU sont accessibles sur le site à la rubrique «CGU».",
              ),
              const PlainTextWidget(
                title:
                    "Toute inscription ou utilisation du site implique l'acceptation sans aucune réserve ni restriction des présentes CGU par l’utilisateur. Lors de l'inscription sur le site via le Formulaire d’inscription, chaque utilisateur accepte expressément les présentes CGU en cochant la case précédant le texte suivant : « Je reconnais avoir lu et compris les CGU et je les accepte ».",
              ),
              const PlainTextWidget(
                title:
                    "En cas de non-acceptation des CGU stipulées dans le présent contrat, l'Utilisateur se doit de renoncer à l'accès des services proposés par le site.BONECOLE INC. SARLU se réserve le droit de modifier unilatéralement et à tout moment le contenu des présentes CGU.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 1 : Les mentions légales",
              ),
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
                      text: "L'édition du site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " L'édition du site est assurée par la Société BONECOLE INC SARLU au capital de 10,000,000 GNF, immatriculée au RCCM sous le numéro GN.TCC.2021.B.13811, dont le siège social est situé à Immeuble BSIC, Lambanyi Marché, Commune de Ratoma, Conakry, République de Guinée.",
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  PlainTextWidget(
                    title: "Numéro de téléphone : +224611238888",
                  ),
                ],
              ),
              Row(
                children: const [
                  PlainTextWidget(
                    title: "Adresse e-mail : contact@bonecole.com",
                    paddingTop: 1,
                  ),
                ],
              ),
              verticalSpacer(15),
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
                      text: "L'hébergeur du site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " est la société BONECOLE INC SARLU, dont le siège social est situé à Immeuble BSIC, Lambanyi marché, Commune de Ratoma, Conakry, République de Guinée, avec le numéro de téléphone : +224611238888.",
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 2 : Accès au site",
              ),
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
                      text: "Le site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " permet à l'utilisateur un accès payant aux services suivants : Ventes de cours en ligne.Le site est accessible en tout lieu à tout Utilisateur âgé de 13 ou plus, ayant un accès à Internet. Les utilisateurs âgés de moins de 13 ans doivent avoir obtenu du(des) titulaire(s) de l'autorité parentale l'autorisation le concernant d'accepter les Conditions Générales d'Utilisation.",
                    ),
                  ],
                ),
              ),
              const PlainTextWidget(
                title:
                    "Tous les frais supportés par l'Utilisateur pour accéder au service (matériel informatique, connexion Internet, coûts des cours etc.) sont à sa charge.L'utilisateur non membre n'a pas accès aux services réservés. Pour cela, il doit s’inscrire en remplissant le formulaire. En acceptant de s’inscrire aux services réservés, l'utilisateur membre s’engage à fournir des informations sincères et exactes concernant ses coordonnées, notamment son adresse email, identifiant Facebook, école d’origine, classe, etc....Pour accéder aux services, l’Utilisateur doit ensuite s'identifier à l'aide de son compte google ou Facebook tout en communiquant son nom, adresse email, identifiant Facebook, école d’origine, numéro de téléphone, et classe dans la section \"mon profil\" après son inscription.Tout Utilisateur membre et régulièrement inscrit pourra également solliciter la fermeture de son compte en nous notifiant de sa volonté via e-mail à l'adresse contact@bonecole.com. Celle-ci sera effective dans un délai raisonnable.",
              ),
              const PlainTextWidget(
                title:
                    "Tout événement dû à un cas de force majeure ayant pour conséquence un dysfonctionnement du site ou serveur et sous réserve de toute interruption ou modification en cas de maintenance, n'engage pas la responsabilité de BONECOLE INC SARLU. Dans ces cas, l’Utilisateur accepte ainsi ne pas tenir rigueur à l’éditeur de toute interruption ou suspension de service, même sans préavis.L'utilisateur a la possibilité de contacter le site par messagerie électronique à l’adresse email de l’éditeur communiqué à l’ARTICLE 1.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 3 : Collecte des données",
              ),
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
                          "Le site fait l’objet de collecte de données concernant les Utilisateurs. Ces données concernent les informations personnelles et la navigation sur le site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " Les données personnelles sont: adresse e-mail, nom, école d’origine, classe, identifiant Facebook et numéro de téléphone. Soit les données de navigation concernent strictement les activités de l’utilisateur sur le site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
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
                title: "ARTICLE 4 : Propriété intellectuelle",
              ),
              const PlainTextWidget(
                title:
                    "Les marques, logos, signes ainsi que tous les contenus du site (textes, images, son...) font l'objet d'une protection par le Code de la propriété intellectuelle et plus particulièrement par le droit d'auteur.La marque BONECOLE est une marque déposée par BONECOLE INC. Toute représentation et/ou reproduction et/ou exploitation partielle ou totale de cette marque, de quelque nature que ce soit, est totalement prohibée.",
              ),
              const PlainTextWidget(
                title:
                    "L'Utilisateur doit solliciter l'autorisation préalable du site pour toute reproduction, publication, copie des différents contenus. Il s'engage à une utilisation des contenus du site dans un cadre strictement privé, toute utilisation à des fins commerciales et publicitaires est strictement interdite.Toute représentation totale ou partielle de ce site par quelque procédé que ce soit, sans l’autorisation expresse de l’exploitant du site Internet constituerait une contrefaçon sanctionnée par la loi en vigueur et le Code de la propriété intellectuelle.",
              ),
              const PlainTextWidget(
                title:
                    "Il est rappelé conformément au Code de propriété intellectuelle que l’Utilisateur qui reproduit, copie ou publie le contenu protégé doit citer l’auteur et sa source.",
              ),
              const ArticleTitle(
                title: "ARTICLE 5 : Responsabilité",
              ),
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
                          "Les sources des informations diffusées sur le site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " sont réputées fiables mais le site ne garantit pas qu’il soit exempt de défauts, d’erreurs ou d’omissions.Les informations communiquées sont présentées à titre indicatif et général sans valeur contractuelle. Malgré des mises à jour régulières, le site",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " ne peut être tenu responsable de la modification des dispositions administratives et juridiques survenant après la publication.",
                    ),
                  ],
                ),
              ),
              const PlainTextWidget(
                title:
                    "De même, le site ne peut être tenue responsable de l’utilisation et de l’interprétation de l’information contenue dans ce site.L'Utilisateur s'assure de garder son mot de passe secret. Toute divulgation du mot de passe, quelle que soit sa forme, est interdite. Il assume les risques liés à l'utilisation de son identifiant et mot de passe. Le site décline toute responsabilité.",
              ),
              verticalSpacer(15),
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
                      text: "Le site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " ne peut être tenu pour responsable d’éventuels virus qui pourraient infecter l’ordinateur ou tout matériel informatique de l’Internaute, suite à une utilisation, à l’accès, ou au téléchargement provenant de ce site.La responsabilité du site ne peut être engagée en cas de force majeure ou du fait imprévisible et insurmontable d'un tiers.",
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 6 : Liens hypertextes",
              ),
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
                          "Des liens hypertextes peuvent être présents sur le site. L'utilisateur est informé qu’en cliquant sur ces liens, il sortira du siteLe site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " Ce dernier n’a pas de contrôle sur les pages web sur lesquelles aboutissent ces liens et ne saurait, en aucun cas, être responsable de leur contenu.",
                    ),
                  ],
                ),
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 7 : Cookies",
              ),
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
                          "L’Utilisateur est informé que lors de ses visites sur le site, un cookie peut s’installer automatiquement sur son logiciel de navigation.Les cookies sont de petits fichiers stockés temporairement sur le disque dur de la machine de l’Utilisateur par votre navigateur et qui sont nécessaires à l’utilisation du site ",
                    ),
                    TextSpan(
                      text: "www.bonecole.com",
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
              verticalSpacer(15),
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
                            "Les cookies ne contiennent pas d’information personnelle et ne peuvent pas être utilisés pour identifier quelqu’un. Un cookie contient un identifiant unique, généré aléatoirement et donc anonyme. Certains cookies expirent à la fin de la visite de l'utilisateur, d’autres restent.L’information contenue dans les cookies est utilisée pour améliorer le site "),
                    TextSpan(
                      text: "www.bonecole.com",
                      style: TextStyle(
                        // fontSize: 25.sp,
                        // fontWeight: FontWeight.w700,
                        color: CustomColors.blueColor,

                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.blueColor,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text:
                          " En naviguant sur le site, L'utilisateur les accepte.L'utilisateur doit toutefois donner son consentement quant à l’utilisation de certains cookies.",
                    ),
                  ],
                ),
              ),
              const PlainTextWidget(
                title:
                    "A défaut d’acceptation, l’Utilisateur est informé que certaines fonctionnalités ou pages risquent de lui être refusées.L’Utilisateur pourra désactiver ces cookies par l’intermédiaire des paramètres figurant au sein de son logiciel de navigation.",
              ),
              verticalSpacer(20),
              const ArticleTitle(
                title: "ARTICLE 8 : Droit applicable et juridiction compétente",
              ),
              const PlainTextWidget(
                title:
                    "La législation guinéenne s'applique au présent contrat. En cas d'absence de résolution amiable d'un litige né entre les parties, les tribunaux guinéens seront seuls compétents pour en connaître.Pour toute question relative à l’application des présentes CGU, vous pouvez joindre l’éditeur aux coordonnées inscrites à l’ARTICLE 1.",
              ),
              verticalSpacer(50),
            ],
          ),
        ),
      ),
    );
  }
}
