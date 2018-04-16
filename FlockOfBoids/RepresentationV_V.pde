import java.util.Map;
public class RepresentationV_V{
  ArrayList<Vector>  vectors;
  HashMap<Vector, ArrayList<Vector>> V_V;
  int kind = TRIANGLES;

  public RepresentationV_V(ArrayList<Vector> vectors, int kind){
    this.vectors = vectors;
    this.kind = kind;
    V_V = createRepresentationV_V();
  }
  
  public HashMap<Vector, ArrayList<Vector>> createRepresentationV_V(){
    HashMap<Vector,  ArrayList<Vector>> ans = new HashMap();
     
    for(int i = 0; i < vectors.size() ; i++){
      ArrayList<Vector> vectorsList = new ArrayList();
      for( int j = 0; j < vectors.size() ; j++){
        if(j != i)
           vectorsList.add(vectors.get(j));
      }
       ans.put(vectors.get(i), vectorsList);
    }
    return ans;
  }
  public void structInmediateShape(){
 
    for(Map.Entry vector : V_V.entrySet()){
       ArrayList<Vector> aux =(ArrayList<Vector>) vector.getValue();
       for(int i = 0; i < aux.size(); i++){
         Vector aux1 =(Vector) vector.getKey();
         renderFace(aux1, aux.get(i), aux.get((i+1)%aux.size()));
       }
    }
  }
    public PShape structRetainedShape(){
      PShape shape;
      //shape.disableStyle();
      shape = createShape();
      shape.beginShape(kind);
     for(Map.Entry vector : V_V.entrySet()){
       ArrayList<Vector> aux =(ArrayList<Vector>) vector.getValue();
       for(int i = 0; i < aux.size(); i++){
         Vector aux1 =(Vector) vector.getKey();
         renderRetainedFace(aux1, aux.get(i), aux.get((i+1)%aux.size()), shape);
       }
     }
    shape.endShape();
   return shape;
  }
   public void renderFace(Vector a, Vector b, Vector c){
    beginShape(kind);
      vertex(a.x(), a.y(), a.z());
      vertex(b.x(), b.y(), b.z());
      vertex(c.x(), c.y(), c.z());
    endShape();
  }
  public void renderRetainedFace(Vector a, Vector b, Vector c, PShape shape){
    shape.vertex(a.x(), a.y(), a.z());
    shape.vertex(b.x(), b.y(), b.z());
    shape.vertex(c.x(), c.y(), c.z());
  }
}
