import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;
  ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
      return _New(news: this.news[index],index:index);
     },
    );
  }
}

class _New extends StatelessWidget {
  
  final Article news;
  final int index;

  const _New({
    @required this.news,
    @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(news,index),
        _CardTitle(news),
        _CardImage(news),
        _CardBody(news),

        _CardButton(),

        SizedBox(height: 10.0,),
        Divider()
      ],
    );

  }
}

class _CardButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: (){},
            fillColor: myTheme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 20.0,),
          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article news;

  const _CardBody(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(news.description!=null?news.description:""),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;

  const _CardImage(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
        child: Container(
          child: news.urlToImage!=null?
          FadeInImage(
            placeholder: AssetImage("assets/img/giphy.gif"), 
            image: NetworkImage(news.urlToImage)
          ):
          Image(image: AssetImage("assets/img/no-image.png"),)
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(news.title,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _CardTopBar(this.news,this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child:  Row(
        children: <Widget>[
          Text("${index + 1}. ",style: TextStyle(color: myTheme.accentColor),),
          Text("${news.source.name}. ",),
        ],
      ),
    );
  }
}