import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {

const CategoriesScreen ({super.key, required this.availableMeals});

//final void Function(Meal meal) onToggleFavorite;
final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController  _animationController;

  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
     // lowerBound: 0,
     // upperBound: 1
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
void _selectCategory(BuildContext context, Category category)
{
  final filteredMeals=widget.availableMeals
  .where((meal)=>meal.categories.contains(category.id))
  .toList();
  Navigator.push(context, MaterialPageRoute(builder:(ctx)=>
  MealsScreen(
    title: category.title, 
    meals: filteredMeals,
   // onToggleFavorite: onToggleFavorite,
    ),
    ),
    );
 // Navigator.of(context).push(route);

}

  @override
  Widget build(BuildContext context) {
   
   return AnimatedBuilder(animation: _animationController, 
   child: GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:2,
         childAspectRatio: 3/2,
         crossAxisSpacing: 20,
        mainAxisSpacing: 20),
      children: [
        //availableCategories.map((category)=>CategoryGridItem(category:category)).toList()
        for(final category in availableCategories)
          CategoryGridItem(category: category,
           onSelectCategory:(){ _selectCategory(context, category);
           },
           ),
      ],


   ),
     builder: (context,child)=> SlideTransition(
      position: 
        Tween(
          begin:const  Offset(0, 0.3),
          end: const Offset(0, 0)
        ).animate(CurvedAnimation(curve: Curves.easeInOut, parent: _animationController)),
            child: child,)
     // Padding(
    //  child: child,
    //  padding: EdgeInsets.only(top:100- _animationController.value *100),
    //  )     
   );
  }
}