import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trair.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectedMeal,
  });

  final Meal meal;

  String get complexityText {
    //[0] helps to acces to the frist carectere
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    //[0] helps to acces to the frist carectere
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  final void Function(Meal meal) onSelectedMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //With that we enforce to create roundend bordes outside the shape, without this
      //Our card can't have border radiius
      clipBehavior: Clip.hardEdge,
      //create a 3d effect to the card
      elevation: 2,
      child: InkWell(
        onTap: () {
          //i'm passing the meal property that I declared
          onSelectedMeal(meal);
        },
        child: Stack(
          children: [
            //Utility helps us to fade out an image with the placeholder
            // display and image when it show ups create a fade in efect
            //Memory image help
            Hero(
              tag: meal.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity, //use as much of with that it has
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),

            //For positioning another widget in front other we use Positioned
            //wi those coordinated, we can asure that this container is going to be in front of
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    //max line helps to force no text more than 2
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      //softWrap help to cut smoothly the title
                      softWrap: true,
                      overflow:
                          TextOverflow.ellipsis, // add ... to a long title
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //Meta data Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12,),
                        
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),

                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
