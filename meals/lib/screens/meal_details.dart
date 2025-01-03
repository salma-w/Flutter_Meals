import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen  extends ConsumerWidget
{
const MealDetailsScreen
({super.key, 
required this.meal,
//required this.onToggleFavorite
});

final Meal meal;
//final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      appBar:  AppBar( 
        title:Text(meal.title),
        actions: [
          IconButton(onPressed: (){
           final wasAdded= ref.
            read(favoriateMealsProvider.notifier)
            .toggleMealFavoriteStatus(meal) ;
            ScaffoldMessenger.of(context).clearSnackBars();
    
           ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(wasAdded? 'Meals added as a favorite.':'Meal Removed'),
           )
    );
                     },
          icon: const Icon(Icons.star)
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
             Image.network(
          meal.imageUrl,      
          width: double.infinity,
          height: 300,
          fit:  BoxFit.cover,
        )  ,
        SizedBox(height: 14,),
        Text('Ingrededients',
        style:Theme.of(context).textTheme.titleLarge!.copyWith(
          color:Theme.of(context).colorScheme.onSurface,
        ),
        ),
        SizedBox(height: 14,),
        for(final Ingrededient in meal.ingredients)
          Text(Ingrededient,style:Theme.of(context).textTheme.bodyMedium!.copyWith(
          color:Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold
        ),          
          ),
        const  SizedBox(height: 24,),
          Text('Steps',
        style:Theme.of(context).textTheme.titleLarge!.copyWith(
          color:Theme.of(context).colorScheme.onSurface,
        ),
        ),
             SizedBox(height: 14,),
        for(final step in meal.steps)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8
            ),
            child: Text(step,
            textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.bodyMedium!.copyWith(
            color:Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold
                  ),          
            ),
          ),
             
          ]
          ),
      )
     );
  }
}