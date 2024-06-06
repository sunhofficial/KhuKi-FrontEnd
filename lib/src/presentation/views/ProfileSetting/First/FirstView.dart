
import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/Second/SecondView.dart';
import '../StepProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'FirstViewModel.dart';

class FirstView extends StatelessWidget {
  FirstView({Key? key}) : super(key: key);
  //  FirstView({Key? key})
  //     : _loginViewModel = FirstViewModel(getIt<UserRepository>()),
  //       super(key: key);
  final UserRepository _userRepository = getIt<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirstViewModel(_userRepository),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: StepProgressBar(currentStep: 1),
              ),
               ProfileSelection(),
              const Spacer(),
              Consumer<FirstViewModel>(
                builder: (context, viewModel, child) {
                  return SizedBox(
                    width: 360,
                    height: 54,
                    child: CupertinoButton(
                      child: const Text("Continue", style: TextStyle(color: Colors.white)),
                      color: Colors.pink,
                      onPressed: viewModel.canSubmit ? () async {
                        bool isSuccess = await viewModel.submitProfile();
                        if (isSuccess) {
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondView()),
            );
                        }
                      } : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProfileSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FirstViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("I am a", style: TextStyle(fontSize: 32)),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: genderSelectionWidget(context, viewModel),
          ),
          const SizedBox(height: 24),
          const Text("My Age", style: TextStyle(fontSize: 32)),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ageSelectionWidget(context, viewModel),
          ),
          const SizedBox(height: 24),
          const Text("정문에서 단과대 거리", style: TextStyle(fontSize: 32)),
          const SizedBox(height: 16,),
          DistanceSlider(viewModel: viewModel),
        ],
      ),
    );
  }
  Widget genderSelectionWidget(BuildContext context, FirstViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.female,
              color: Colors.pink,
              size: 24,
            ),
          ),
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("여자", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Icon(Icons.check, size: 16),
            ],
          ),
          onPressed: () => viewModel.selectGender(false),
          style: ElevatedButton.styleFrom(
            foregroundColor: viewModel.isFemaleSelected ? Colors.white : Colors.black,
            backgroundColor: viewModel.isFemaleSelected ? Colors.pink : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.male,
              color: Colors.blue,
              size: 24,
            ),
          ),
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("남자", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Icon(Icons.check, size: 16),
            ],
          ),
          onPressed: () => viewModel.selectGender(true),
          style: ElevatedButton.styleFrom(
            foregroundColor: viewModel.isMaleSelected ? Colors.white : Colors.black,
            backgroundColor: viewModel.isMaleSelected ? Colors.blue : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget ageSelectionWidget(BuildContext context, FirstViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAgeGroup(context, "assets/ageYoung.png", "19 - 21살", 0, viewModel),
        _buildAgeGroup(context, "assets/ageMiddle.png", "22 - 25살", 1, viewModel),
        _buildAgeGroup(context, "assets/ageOld.png", "26..ing", 2, viewModel),
      ],
    );
  }

  Widget _buildAgeGroup(BuildContext context, String imageString, String agearea, int index, FirstViewModel viewModel) {
    bool isSelected = index == viewModel.selectedAgeGroup;
    return GestureDetector(
      onTap: () => viewModel.selectAgeGroup(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isSelected ? 1.0 : 0.5,
            child: Image.asset(imageString, width: 84, height: 84, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(agearea,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: isSelected ? Colors.black : Colors.grey)),
        ],
      ),
    );
  }

  Widget DistanceSlider({required FirstViewModel viewModel}) {
    final labels = ["정문", "5분","10분","15분","20분","25분","30분"];
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            activeColor: Colors.pink,
            value: viewModel.distanceValue,
            divisions: 6,
            min: 0,
            max: 30,
            label: '${viewModel.distanceValue.round()}분',
            onChanged: (double value) {
              viewModel.updateDistance(value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: labels.map((label) => Text(label, style: const TextStyle(fontSize: 16))).toList(),
          ),
        ),
      ],
    );
  }
}
// class ProfileSelection extends StatefulWidget {
//   @override
//   _ProfileSelectionState createState() => _ProfileSelectionState();
// }
// class _ProfileSelectionState extends State<ProfileSelection> {
//   bool isMaleSelected = false;
//   bool isFemaleSelected = false;
//   int selectedAgeGroup = -1;
//   double distanceValue = 0;

//   void _selectGender(bool isMale) {
//     setState(() {
//       isMaleSelected = isMale;
//       isFemaleSelected = !isMale;
//     });
//   }

//    @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16), // 여기서 모든 자식 위젯에 대한 패딩을 설정합니다.
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("I am a", style: TextStyle(fontSize: 32)),
//           SizedBox(height: 16,),
//           Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: genderSelectionWidget(),),
//           SizedBox(height: 24),
//           Text("My Age", style: TextStyle(fontSize: 32)),
//           SizedBox(height: 16,),
//           Padding(padding: EdgeInsets.symmetric(horizontal: 24), child:   ageSelectionWidget(),),
        
//           SizedBox(height: 24),
//           Text("정문에서 단과대 거리", style: TextStyle(fontSize: 32)),
//           SizedBox(height: 16,),
//           DistanceSlider(),
//         ],
//       ),
//     );
   
//   }

//   Widget genderSelectionWidget() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton.icon(
//             icon: Padding(
//               padding: EdgeInsets.all(16),
//               child: const Icon(
//                 Icons.female,
//                 color: Colors.pink,
//                 size: 24,
//               ),
//             ),
//             label: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text("여자",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                 Icon(Icons.check, size: 16),
//               ],
//             ),
//             onPressed: () => _selectGender(false),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: isFemaleSelected ? Colors.white : Colors.black,
//               backgroundColor: isFemaleSelected ? Colors.pink : Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//             )),
//         SizedBox(height: 8),
//         ElevatedButton.icon(
//             icon: Padding(
//               padding: EdgeInsets.all(16),
//               child: const Icon(
//                 Icons.male,
//                 color: Colors.blue,
//                 size: 24,
//               ),
//             ),
//             label: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   "남자",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Icon(Icons.check, size: 16),
//               ],
//             ),
//             onPressed: () => _selectGender(true),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: isMaleSelected ? Colors.white : Colors.black,
//               backgroundColor: isMaleSelected ? Colors.blue : Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//             )),
//       ],
//     );
//   }
//     Widget ageSelectionWidget() {
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       _buildAgeGroup("assets/ageYoung.png", "19 - 21살", 0),
//       _buildAgeGroup("assets/ageMiddle.png", "22 - 25살", 1),
//       _buildAgeGroup("assets/ageOld.png", "26..ing", 2),
//     ]);
//   }

//   Widget _buildAgeGroup(String imageString, String agearea, int index) {
//     bool isSelected = index == selectedAgeGroup;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAgeGroup = index;
//         });
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Opacity(
//             opacity: isSelected ? 1.0 : 0.5,
//             child: Image.asset(imageString,
//                 width: 84, height: 84, fit: BoxFit.contain),
//           ),
//           SizedBox(height: 8),
//           Text(agearea,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w300,
//                   color: isSelected ? Colors.black : Colors.grey)),
//         ],
//       ),
//     );
//   }

 
//   Widget DistanceSlider() {
//     final labels = ["정문", "5분","10분","15분","20분","25분","30분"];
//   return Column(
//     children: [
//       SliderTheme(
//         data: SliderThemeData(
//           trackShape: RoundedRectSliderTrackShape(),
//           trackHeight: 4.0,
//           thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
//           overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
//           tickMarkShape: SliderTickMarkShape.noTickMark,
//           showValueIndicator: ShowValueIndicator.always,
//         ),
//         child: Slider(
//           activeColor: Colors.pink,
//           value: distanceValue,
//           divisions: 6,
//           min: 0,
//           max: 30,
//           label: '${distanceValue.round()}분',
//           onChanged: (double value) {
//             setState(() {
//               distanceValue = value;
//             });
//           },
//         ),
//       ),
//     Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
//     child:    Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: 
//         labels.map((label) => Text(label, style: TextStyle(fontSize: 16))).toList(),
        
//       ),)
   
//     ],
//   );
// }


