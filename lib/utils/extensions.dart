
import 'dart:core';
import 'dart:math';

extension RandomList<T> on List<T>{

  T? randomOrNull(){
    if(isEmpty)return null;
    return this[Random().nextInt(length)];
  }
}

extension IncrementMap<T> on Map<T,int>{

  incrementIfExist(T key){
    if(containsKey(key)){
      this[key] = (this[key]! + 1);
    }
  }

  get(T key)=>containsKey(key)?this[key]!:0;
}