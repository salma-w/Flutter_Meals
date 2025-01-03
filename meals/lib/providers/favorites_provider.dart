
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>>{
   FavoritesMealsNotifier():super([]);


   bool toggleMealFavoriteStatus(Meal meal){
   final mealIsFavoriate= state.contains(meal);
   if(mealIsFavoriate){
    state= state.where((m)=>m.id !=meal.id).toList();
    return false;
   }
   else{
      state =[...state, meal];
      return true;
   }
  

   }
}

final favoriateMealsProvider=StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref){
return FavoritesMealsNotifier();
  }
);
