import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget 
  {
    const MealsScreen({super.key,  this.title, required this.meals});
    final String? title;
    final List<Meal> meals;
  //  final void Function(Meal meal) onToggleFavorite;

void selectMeal(BuildContext context,Meal meal)
{
  
  Navigator.of(context).push(
    MaterialPageRoute(builder: (ctx)=> MealDetailsScreen
    (
      meal: meal
     // onToggleFavorite:onToggleFavorite),
   ),
  )
  );
}

    @override
  Widget build(BuildContext context) {
    Widget content=Center(
  child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
     Text('Un oh... nothing heer!',
    style:  Theme.of(context).textTheme.headlineLarge!.copyWith(
      color: Theme.of(context).colorScheme.onSurface
      ),
    ),
    const SizedBox(height: 16,),
    Text('Try selecting a differnt category', style:  Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: Theme.of(context).colorScheme.onSurface
      ),
      ),
    
  ],
),
);

    
     if(meals.isNotEmpty){
    content= content=ListView.builder(
      itemCount: meals.length,
        itemBuilder: (ctx,index)=>MealItem(
          meal: meals[index], 
          onSelectedMeal:(meal){
          selectMeal(context, meal);
        }),
          );
     }

    
    if(title==null){
      return content;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content
            );
  }
} 