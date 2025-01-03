import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/screens/filters.dart';

const kInitialFilters={
     Filter.glutenFree:false,
     Filter.lactoseFree:false,
     Filter.vegetarian:false,
     Filter.vegan:false};

class TabsScreen extends ConsumerStatefulWidget{
 //class TabsScreen extends StatefulWidget{
const TabsScreen({super.key});

  @override
  //State<TabsScreen> createState()
    ConsumerState<TabsScreen> createState()
   {
    return _TabsScreenState();
  }
}
  
class _TabsScreenState extends ConsumerState<TabsScreen>{
  
   Map<Filter,bool> _selectedFilters= {
     Filter.glutenFree:false,
     Filter.lactoseFree:false,
     Filter.vegetarian:false,
     Filter.vegan:false,
  };

  int _selectedPageIndex=0;
  //final List<Meal> _favoritesmeals=[];
   //void _showInfoMessage(String message)
  //{
  //  ScaffoldMessenger.of(context).clearSnackBars();
    
  //  ScaffoldMessenger.of(context).showSnackBar(
  //    SnackBar(content: Text(message))
  //  );
  //}

 // void _toggleMealFavoriteStatus(Meal meal){
 //   final isExisting=_favoritesmeals.contains(meal);
 //   if(isExisting){
   //   setState(() {
   //   _favoritesmeals.remove(meal);
 //     _showInfoMessage("Meal is no longer a favorite.");
 //     });
  //  }
  //  else{
 //     setState(() {
 //     _favoritesmeals.add(meal);
  //    _showInfoMessage("Meal is marked as a favoriate.");
   //   });
  //  }
  //  }
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  void _setScreen(String identifier) async
  {  
    Navigator.of(context).pop();

     if(identifier=='filters')
     {
        final result= await Navigator.of(context).push<Map<Filter,bool>>(
          MaterialPageRoute(
            builder: (ctx)=>  FiltersScreen(currentFilters: _selectedFilters,)
        ),
        );     
        setState(() {
                  _selectedFilters=result??kInitialFilters;

        });   
        }
  
}
  @override
  Widget build(BuildContext context) {
   // final availableMeals=dummyMeals.where((meal)
   final meals=ref.watch(mealsProvider);
  final availableMeals=meals.where((meal)
    {
    if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
    return false;}
    if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
    return false;}
    if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
    return false;}
    if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
    return false;}
    
    return true;
  }).toList();
    
    Widget activePage= CategoriesScreen(
     // onToggleFavorite:_toggleMealFavoriteStatus,
      availableMeals: availableMeals,
      );
    var activePageTitle='Categories';


    if(_selectedPageIndex==1){
      final favoriateMeals=ref.watch(favoriateMealsProvider);
      activePage =MealsScreen( 
        meals:favoriateMeals,//_favoritesmeals, 
     // onToggleFavorite: _toggleMealFavoriteStatus,
     ); 
      activePageTitle='Favorites';
        }

    return Scaffold(
      appBar: AppBar(
         title: Text(activePageTitle),
        ),
        drawer: MainDrawer(onSelectScreen: _setScreen,),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')

          ]) ,
    );
  }

  }
